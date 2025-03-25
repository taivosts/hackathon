// Generated with Bot Builder V4 SDK Template for Visual Studio CoreBot v4.22.0

using AdaptiveCards;
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
                var workspaces = await _anythingLLMService.GetWorkspacesAsync(cancellationToken);
                var welcomeCard = CreateListCard(workspaces);
                var response = MessageFactory.Attachment(welcomeCard, ssml: "Welcome to AI Dreamer!");
                await turnContext.SendActivityAsync(response, cancellationToken);
            }
        }
    }

    public Attachment CreateListCard(List<AnythingLLMWorkSpace> items)
    {
        // Create the base card
        var card = new AdaptiveCard(new AdaptiveSchemaVersion(1, 3));
        // Add a title
        card.Body.Add(new AdaptiveTextBlock
        {
            Text = "Please select a workspace",
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

            if (action is not null && action == "optionSelected")
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

        turnContext.TurnState.Set(AnythingLLMConst.ANYTHING_LLM_WORKSPACE, userChoiceState);
        await base.OnMessageActivityAsync(turnContext, cancellationToken);
    }
}
