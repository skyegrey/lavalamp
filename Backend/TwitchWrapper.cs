//To add Twitchlib, Click on extensions -> Type 'Nuget' -> Nuget Package Manager GUI -> Install -> [Control] + [Shift] + [P] -> Nuget Package -> TwitchLib.Client

using System;
using System.Collections.Generic;
using TwitchLib.Client;
using TwitchLib.Client.Events;
using TwitchLib.Client.Models;

public class Character
{
    public int ExperiencePoints { get; set; }
    public Dictionary<string, int> Skills { get; set; }

    public Character()
    {
        ExperiencePoints = 0;
        Skills = new Dictionary<string, int>();
    }
}

public class TwitchBot
{
    private TwitchClient client;
    private Dictionary<string, Character> characters = new Dictionary<string, Character>();

    public TwitchBot(string username, string password, string channel)
    {
        var credentials = new ConnectionCredentials(username, password);
        client = new TwitchClient();
        client.Initialize(credentials, channel);
        client.OnMessageReceived += OnMessageReceived;
        client.OnWhisperReceived += OnWhisperReceived;
        client.Connect();
    }

    private void OnMessageReceived(object sender, OnMessageReceivedArgs e)
    {
        if (e.ChatMessage.Message.StartsWith("!join"))
        {
            client.SendWhisper(e.ChatMessage.Username, "You have joined the chat!");
        }
    }

    private void OnWhisperReceived(object sender, OnWhisperReceivedArgs e)
    {
        if (e.WhisperMessage.Message.StartsWith("!increase"))
        {
            string[] commandParts = e.WhisperMessage.Message.Split(' ');
            if (commandParts.Length >= 2)
            {
                string skillName = commandParts[1];
                int amount = 1;
                if (commandParts.Length >= 3 && int.TryParse(commandParts[2], out int parsedAmount))
                {
                    amount = parsedAmount;
                }

                IncreaseSkill(e.WhisperMessage.Username, skillName, amount);
                client.SendWhisper(e.WhisperMessage.Username, $"Skill '{skillName}' increased by {amount}.");
            }
            else
            {
                client.SendWhisper(e.WhisperMessage.Username, "Invalid command usage. Usage: !increase <skill name> [<amount>]");
            }
        }
    }

    private void IncreaseSkill(string username, string skillName, int amount)
    {
        if (!characters.ContainsKey(username))
        {
            characters[username] = new Character();
        }

        Character character = characters[username];

        if (!character.Skills.ContainsKey(skillName))
        {
            character.Skills[skillName] = 0;
        }

        character.Skills[skillName] += amount;
        character.ExperiencePoints += amount;

        // Check if the user leveled up
        int level = character.ExperiencePoints / 100; // assuming 100 points per level
        if (level * 100 > character.ExperiencePoints && level > 0)
        {
            // User leveled up
            client.SendWhisper(username, $"Congratulations! You've reached level {level}.");
        }
    }
}

class Program
{
    static void Main(string[] args)
    {
        string username = "YourTwitchBotUsername";
        string password = "YourTwitchOAuthToken"; // You can get this from https://twitchapps.com/tmi/
        string channel = "YourChannelName";

        TwitchBot bot = new TwitchBot(username, password, channel);

        // Keep the console window open to maintain the connection
        Console.ReadLine();
    }
}
