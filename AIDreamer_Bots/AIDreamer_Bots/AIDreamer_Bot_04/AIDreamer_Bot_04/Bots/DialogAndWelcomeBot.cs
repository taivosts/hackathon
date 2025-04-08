// Generated with Bot Builder V4 SDK Template for Visual Studio CoreBot v4.22.0

using AdaptiveCards;
using Microsoft.Bot.Builder;
using Newtonsoft.Json.Linq;

namespace AIDreamer_Bot_04.Bots;

public class DialogAndWelcomeBot<T> : DialogBot<T>
    where T : Dialog
{
    private readonly IAnythingLLMService _anythingLLMService;
    private readonly IStatePropertyAccessor<UserChoiceState> _userChoiceAccessor;

    public DialogAndWelcomeBot(ConversationState conversationState,
        UserState userState,
        T dialog,
        ILogger<DialogBot<T>> logger,
        IAnythingLLMService anythingLLMService)
        : base(conversationState, userState, dialog, logger)
    {
        _anythingLLMService = anythingLLMService;
        _userChoiceAccessor = UserState.CreateProperty<UserChoiceState>("UserChoiceState");
    }

    protected override async Task OnMembersAddedAsync(IList<ChannelAccount> membersAdded, ITurnContext<IConversationUpdateActivity> turnContext, CancellationToken cancellationToken)
    {
        foreach (var member in membersAdded)
        {
            // Greet anyone that was not the target (recipient) of this message.
            // To learn more about Adaptive Cards, see https://aka.ms/msbot-adaptivecards for more details.
            if (member.Id != turnContext.Activity.Recipient.Id)
            {
                // Try to access email if available
                var userEmail = member.Properties?.ContainsKey("email") == true
                    ? member.Properties["email"]?.ToString()
                    : null;

                await DisplayWorkspaceCards(userEmail, member.Name, turnContext, cancellationToken);
            }
        }
    }

    private async Task DisplayWorkspaceCards(string email, string name, ITurnContext turnContext, CancellationToken cancellationToken)
    {
        List<AnythingLLMWorkSpace> workspaces;
        if (email is not null)
        {
            workspaces = await _anythingLLMService.GetWorkspacesByEmailAsync(email, cancellationToken);
        }
        else
        {
            workspaces = await _anythingLLMService.GetWorkspacesAsync(cancellationToken);
        }

        workspaces = workspaces.Where(ws => ws.Slug != AnythingLLMConst.ANYTHING_LLM_WORKSPACE_GENERAL).ToList();

        var welcomeCard = CreateListCard(name, workspaces ?? []);
        var response = MessageFactory.Attachment(welcomeCard, ssml: "Welcome to AI Dreamer!");
        await turnContext.SendActivityAsync(response, cancellationToken);
    }

    public Attachment CreateListCard(string name, List<AnythingLLMWorkSpace> items)
    {
        // Create the base card
        var card = new AdaptiveCard(new AdaptiveSchemaVersion(1, 3));
        // Add a title
        card.Body.Add(new AdaptiveTextBlock
        {
            Text = $"Hi {name}, please select a workspace",
            Weight = AdaptiveTextWeight.Bolder,
            Size = AdaptiveTextSize.Medium
        });

        // Create choice items from the array
        var choices = new List<AdaptiveChoice>();
        foreach (var option in items)
        {
            choices.Add(new AdaptiveChoice
            {
                Title = option.Name,
                Value = option.Slug
            });
        }

        // Create the dropdown (Input.ChoiceSet)
        var dropdown = new AdaptiveChoiceSetInput
        {
            Id = "selectedOption",
            Style = AdaptiveChoiceInputStyle.Compact, // Dropdown style (use Expanded for radio buttons)
            Choices = choices,
            Value = items.Count > 0 ? items[0].Slug : "No workspace available" // Pre-selected value (optional)
        };

        // Add the dropdown to the card body
        card.Body.Add(dropdown);

        // Add submit button
        card.Actions.Add(new AdaptiveSubmitAction
        {
            Title = "Submit",
            Data = new Dictionary<string, object>
            {
                { "action", "optionSelected" }
            }
        });

        card.Actions.Add(new AdaptiveSubmitAction
        {
            Title = "Refresh Workspace",
            Data = new Dictionary<string, object>
            {
                { "action", "optionRefresh" }
            }
        });


        // Create attachment from card
        return new Attachment
        {
            ContentType = AdaptiveCard.ContentType,
            Content = card
        };
    }

    protected override async Task OnMessageActivityAsync(ITurnContext<IMessageActivity> turnContext, CancellationToken cancellationToken)
    {
        // Get the user state
        var userChoiceState = await _userChoiceAccessor.GetAsync(turnContext, () => new UserChoiceState(), cancellationToken);

        // Check if this is a message or a card action
        if (turnContext.Activity.Value != null)
        {
            // Parse the Value property
            var value = JObject.Parse(turnContext.Activity.Value.ToString());
            string action = value["action"]?.ToString();

            if (action is not null)
            {
                if (action == "optionRefresh")
                {
                    var workspaces = await _anythingLLMService.GetWorkspacesAsync(cancellationToken);
                    var welcomeCard = CreateListCard(turnContext.Activity.Conversation.Name, workspaces);
                    var response = MessageFactory.Attachment(welcomeCard, ssml: "Welcome to AI Dreamer!");
                    await turnContext.SendActivityAsync(response, cancellationToken);
                    return;
                }
                else if (action == "optionSelected")
                {
                    // Get the selected item
                    string slug = value["selectedOption"].ToString();

                    userChoiceState.SelectedOption = slug;
                    userChoiceState.SessionId = Guid.NewGuid().ToString();
                    // Save state
                    await UserState.SaveChangesAsync(turnContext, false, cancellationToken);

                    turnContext.TurnState.Set(AnythingLLMConst.ANYTHING_LLM_WORKSPACE, userChoiceState);

                    await Dialog.RunAsync(
                       turnContext,
                       ConversationState.CreateProperty<DialogState>(nameof(DialogState)),
                       cancellationToken);

                    return;
                }
            }
        }
        else if (turnContext.Activity.Text is not null && turnContext.Activity.Text.Contains(AnythingLLMConst.ANYTHING_LLM_CHAT_SELECT))
        {
            await DisplayWorkspaceCards(null, turnContext.Activity.Conversation.Name, turnContext, cancellationToken);
            return;
        }

        if (string.IsNullOrEmpty(userChoiceState.SelectedOption))
        {
            userChoiceState.SelectedOption = AnythingLLMConst.ANYTHING_LLM_WORKSPACE_DEFAULT;
        }

        turnContext.TurnState.Set(AnythingLLMConst.ANYTHING_LLM_WORKSPACE, userChoiceState);
        await base.OnMessageActivityAsync(turnContext, cancellationToken);
    }
}
