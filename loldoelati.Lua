task.spawn(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    local player = Players.LocalPlayer
    local playerGui = player:WaitForChild("PlayerGui")

    local coinTextObj = nil

    local CoinsLabel = player.PlayerGui.MenuGui.TopRight.CoinsFrame.CoinsDisplay.Coins
    
    -- FPS
    local FPS = 0
    local Frames = 0
    local LastTime = tick()

    local function findCoins()
        for _, v in pairs(playerGui:GetDescendants()) do
            if v.Name == "Coins" and v:IsA("TextLabel") then
                coinTextObj = v
                break
            end
        end
    end
    
    RunService.RenderStepped:Connect(function()
        Frames += 1
    
        if tick() - LastTime >= 1 then
            FPS = Frames
            Frames = 0
            LastTime = tick()
        end
    end)
    
    findCoins()
    
    local coins = coinTextObj and coinTextObj.Text:gsub("%D", "") or "0"
    
    -- UPDATE
    RunService.RenderStepped:Connect(function()
        findCoins()
    
        local Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        local Time = os.date("%H:%M:%S")
    
        CoinsLabel.Text =
            "Coins: " .. coins ..
            "\nFPS: " .. FPS ..
            "\nPing: " .. Ping .. " ms" ..
            "\nTime: " .. Time
    end)
end)
