using Microsoft.Bot.Builder.Integration.AspNet.Core;
using Microsoft.Bot.Connector.Authentication;

var builder = WebApplication.CreateBuilder(args);
builder.Logging.AddDebug();
builder.Logging.AddConsole();

builder.Services.AddHttpClient().AddControllers().AddNewtonsoftJson();

builder.Configuration["MicrosoftAppId"] = builder.Configuration["BOT_ID"];
builder.Configuration["MicrosoftAppType"] = builder.Configuration["BOT_TYPE"];
builder.Configuration["MicrosoftAppPassword"] = builder.Configuration["BOT_PASSWORD"];
builder.Configuration["MicrosoftAppTenantId"] = builder.Configuration["BOT_TENANT_ID"];
// Create the Bot Framework Authentication to be used with the Bot Adapter.
builder.Services.AddSingleton<BotFrameworkAuthentication, ConfigurationBotFrameworkAuthentication>();

// Create the Bot Adapter with error handling enabled.
builder.Services.AddSingleton<IBotFrameworkHttpAdapter, AdapterWithErrorHandler>();

// Create the storage we'll be using for User and Conversation state. (Memory is great for testing purposes.)
builder.Services.AddSingleton<IStorage, MemoryStorage>();

// Create the User state. (Used in this bot's Dialog implementation.)
builder.Services.AddSingleton<UserState>();

// Create the Conversation state. (Used by the Dialog system itself.)
builder.Services.AddSingleton<ConversationState>();

builder.Services.AddAnythingLLM(builder.Configuration);

// Create the bot as a transient. In this case the ASP Controller is expecting an IBot.
builder.Services.AddTransient<IBot, DialogAndWelcomeBot<AnythingLLMDialog>>();

var app = builder.Build();

if (app.Environment.IsDevelopment())
{
    app.UseDeveloperExceptionPage();
}
else
{
    app.UseHttpsRedirection();
}

app.UseDefaultFiles();
app.UseStaticFiles();
app.UseWebSockets();
app.UseRouting();
app.UseAuthorization();
app.UseEndpoints(endpoints =>
    {
        endpoints.MapControllers();
    });

app.Run();