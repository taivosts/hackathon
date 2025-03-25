using AIDreamer_Bot_04.Dialogs;
using AIDreamer_Bot_04.Options;
using AIDreamer_Bot_04.Services;

namespace AIDreamer_Bot_04;

public static class Startup
{
    public static IServiceCollection AddAnythingLLM(this IServiceCollection services, IConfiguration configuration)
    {
        services.Configure<AnythingLLMOptions>(configuration.GetSection(AnythingLLMOptions.SectionName));

        services.AddSingleton<IAnythingLLMService, AnythingLLMService>();
        // The AnythingLLMDialog that will be run by the bot.
        services.AddSingleton<AnythingLLMDialog>();

        return services;
    }
}
