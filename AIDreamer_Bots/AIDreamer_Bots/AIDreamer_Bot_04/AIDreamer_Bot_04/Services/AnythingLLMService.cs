using System.Text;
using System.Text.Json;

namespace AIDreamer_Bot_04.Services;

public interface IAnythingLLMService
{
    Task<bool> GetAuthAsync(CancellationToken cancellationToken = default);

    Task<AnythingLLMModels> GetCompletionAsync(string prompt, string workspace = "attt", string sessionId = null, CancellationToken cancellationToken = default);
    Task<List<AnythingLLMWorkSpace>> GetWorkspacesAsync(CancellationToken cancellationToken = default);
}

public class AnythingLLMService : IAnythingLLMService
{
    private readonly AnythingLLMOptions _options;
    private readonly HttpClient _httpClient;
    private readonly ILogger<AnythingLLMDialog> _logger;
    private static JsonSerializerOptions _jsonOptions = new JsonSerializerOptions(JsonSerializerDefaults.Web);

    public AnythingLLMService(ILogger<AnythingLLMDialog> logger,
        IOptions<AnythingLLMOptions> options,
        IHttpClientFactory httpClientFactory)
    {
        _logger = logger;
        _options = options.Value;
        _httpClient = httpClientFactory.CreateClient(AnythingLLMConst.ANYTHING_LLM_CLIENT);
        _httpClient.BaseAddress = new Uri(_options.APIEndpoint);
        _httpClient.DefaultRequestHeaders.Add("Authorization", $"Bearer {_options.APIKey}");
    }

    public async Task<bool> GetAuthAsync(CancellationToken cancellationToken = default)
    {
        var response = await _httpClient.PostAsync("api/v1/auth", null, cancellationToken);
        return response.IsSuccessStatusCode;
    }

    public async Task<AnythingLLMModels> GetCompletionAsync(string prompt, string workspace = AnythingLLMConst.ANYTHING_LLM_WORKSPACE_DEFAULT, string sessionId = null, CancellationToken cancellationToken = default)
    {
        try
        {
            var requestBody = new
            {
                message = prompt,
                mode = "chat",
                sessionId = sessionId,
            };
            var content = new StringContent(JsonSerializer.Serialize(requestBody, _jsonOptions), Encoding.UTF8, "application/json");

            var response = await _httpClient.PostAsync($"api/v1/workspace/{workspace}/chat", content);
            response.EnsureSuccessStatusCode();

            var result = await response.Content.ReadAsStringAsync();
            _logger.LogInformation($"API Response: {result}");

            return JsonSerializer.Deserialize<AnythingLLMModels>(result, _jsonOptions);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error in GetCompletionAsync");
            return new AnythingLLMModels { Error = ex.Message };
        }
    }

    public async Task<List<AnythingLLMWorkSpace>> GetWorkspacesAsync(CancellationToken cancellationToken = default)
    {
        try
        {
            var response = await _httpClient.GetAsync("api/v1/workspaces", cancellationToken);
            response.EnsureSuccessStatusCode();

            var result = await response.Content.ReadAsStringAsync();
            _logger.LogInformation($"API Response: {result}");

            var workspaces = JsonSerializer.Deserialize<AnythingLLMWorkSpaceResponse>(result, _jsonOptions);
            return workspaces.Workspaces;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error in GetWorkspacesAsync");
            return new List<AnythingLLMWorkSpace>();
        }
    }
}
