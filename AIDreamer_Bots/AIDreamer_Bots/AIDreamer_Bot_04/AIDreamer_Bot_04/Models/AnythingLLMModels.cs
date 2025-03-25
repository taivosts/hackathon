namespace AIDreamer_Bot_04.Models;

public class AnythingLLMModels
{
    public string Id { get; set; }
    public string Type { get; set; }
    public string TextResponse { get; set; }
    public List<AnythingLLMSource> Sources { get; set; }
    public bool Close { get; set; }
    public string Error { get; set; }
}

public class AnythingLLMSource
{
    public string Title { get; set; }
    public string Chunk { get; set; }
}

public class AnythingLLMRequest
{
    public string Message { get; set; }
}

public class AnythingLLMWorkSpace
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Slug { get; set; }
    public DateTime CreatedAt { get; set; }
    public float? OpenAiTemp { get; set; }
    public DateTime LastUpdatedAt { get; set; }
    public int OpenAiHistory { get; set; }
    public string OpenAiPrompt { get; set; }
}

public class AnythingLLMWorkSpaceResponse
{
    public List<AnythingLLMWorkSpace> Workspaces { get; set; }
}


public class AnythingLLMThread
{
    public int Id { get; set; }
    public string Name { get; set; }
    public string Slug { get; set; }
    public int user_id { get; set; }
    public int workspace_id { get; set; }
}

public class AnythingLLMNewThreadResponse
{
    public AnythingLLMThread Thread { get; set; }
}