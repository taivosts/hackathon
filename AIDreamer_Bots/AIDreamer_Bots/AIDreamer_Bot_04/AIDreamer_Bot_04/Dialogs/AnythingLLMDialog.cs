namespace AIDreamer_Bot_04.Dialogs;

public class AnythingLLMDialog : ComponentDialog
{
    private readonly ILogger _logger;
    private readonly IAnythingLLMService _anythingLLMService;

    public AnythingLLMDialog(ILogger<AnythingLLMDialog> logger,
        IAnythingLLMService anythingLLMService)
        : base(nameof(AnythingLLMDialog))
    {
        _logger = logger;
        _anythingLLMService = anythingLLMService;

        // Define the conversation flow
        AddDialog(new TextPrompt(nameof(TextPrompt)));
        var waterfallSteps = new WaterfallStep[]
        {
            InitialStepAsync,
            ProcessRequestStepAsync,
            ProcessResponseStepAsync
        };
        AddDialog(new WaterfallDialog(nameof(WaterfallDialog), waterfallSteps));
        InitialDialogId = nameof(WaterfallDialog);
    }

    private async Task<DialogTurnResult> InitialStepAsync(WaterfallStepContext stepContext, CancellationToken cancellationToken)
    {
        // Get the user's message from context
        var messageText = stepContext.Context.Activity.Text;

        // If this is the start of conversation, display welcome message
        if (string.IsNullOrEmpty(messageText))
        {
            await stepContext.Context.SendActivityAsync(
                MessageFactory.Text("👋 Hi there! I'm your AI assistant. How can I help you today?"),
                cancellationToken);

            return await stepContext.PromptAsync(nameof(TextPrompt),
                new PromptOptions { Prompt = MessageFactory.Text("Ask me anything!!") },
                cancellationToken);
        }

        return await stepContext.ContinueDialogAsync(cancellationToken);
    }

    private async Task<DialogTurnResult> ProcessRequestStepAsync(WaterfallStepContext stepContext, CancellationToken cancellationToken)
    {
        // Get the user's message from context
        var messageText = stepContext.Context.Activity.Text;
        var workspace = stepContext.Context.TurnState.Get<UserChoiceState>(AnythingLLMConst.ANYTHING_LLM_WORKSPACE);

        if (string.IsNullOrEmpty(workspace?.SelectedOption))
        {
            // Send the response to the user
            await stepContext.Context.SendActivityAsync(
                MessageFactory.Text("Please select a workspace to continue!"),
                cancellationToken);

            // Restart the dialog to handle the next message
            return await stepContext.CancelAllDialogsAsync(cancellationToken);
        }

        // Process the user's query
        await stepContext.Context.SendActivityAsync(
            MessageFactory.Text("Let me think about that..."),
            cancellationToken);

        try
        {
            var response = await _anythingLLMService.GetCompletionAsync(messageText, workspace.SelectedOption, workspace.SessionId);
            return await stepContext.NextAsync(response, cancellationToken);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error processing message");
            return await stepContext.NextAsync(new AnythingLLMModels { Error = ex.Message }, cancellationToken);
        }
    }

    private async Task<DialogTurnResult> ProcessResponseStepAsync(WaterfallStepContext stepContext, CancellationToken cancellationToken)
    {
        var response = stepContext.Result as AnythingLLMModels;

        string responseMessage;
        if (response == null || !string.IsNullOrEmpty(response.Error))
        {
            responseMessage = "Sorry, I encountered an issue processing your request. Please try again.";
        }
        else
        {
            responseMessage = response.TextResponse;
        }

        // Send the response to the user
        await stepContext.Context.SendActivityAsync(
            MessageFactory.Text(responseMessage),
            cancellationToken);

        // Restart the dialog to handle the next message
        return await stepContext.ContinueDialogAsync(cancellationToken);
    }
}
