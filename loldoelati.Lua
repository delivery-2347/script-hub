task.spawn(function()
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")
    local playerGui = player:WaitForChild("PlayerGui")
    
    local LocalPlayer = Players.LocalPlayer
    local coinTextObj
    
    local function findCoins()
        if coinTextObj and coinTextObj.Parent then
            return
        end
    
        for _, v in ipairs(playerGui:GetDescendants()) do
            if v.Name == "Coins" and v:IsA("TextLabel") then
                coinTextObj = v
                return
            end
        end
    end

    local CoinsLabel = LocalPlayer.PlayerGui.MenuGui.TopRight.CoinsFrame.CoinsDisplay.Coins
    
    -- FPS
    local FPS = 0
    local Frames = 0
    local LastTime = tick()
    
    RunService.RenderStepped:Connect(function()
        Frames += 1
    
        if tick() - LastTime >= 1 then
            FPS = Frames
            Frames = 0
            LastTime = tick()
        end
    end)
    
    -- UPDATE
    RunService.RenderStepped:Connect(function()
        findCoins()
    
        local Coins = "0"
        if coinTextObj then
            Coins = coinTextObj.Text:gsub("%D", "")
        end

        local Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
        local Time = os.date("%H:%M:%S")

        CoinsLabel.Text =
            "Coins: " .. Coins ..
            "\nFPS: " .. FPS ..
            "\nPing: " .. Ping .. " ms" ..
            "\nTime: " .. Time
    end)
end)
