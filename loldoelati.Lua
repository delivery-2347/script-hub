local CloneMenu = game.Players.LocalPlayer.PlayerGui.MenuGui:Clone()
CloneMenu.DisplayOrder = 0
CloneMenu.Name = "CloneMenu"
local ObjectsToRemove = {
	"Menu",
	"Back",
	"Bought",
	"Close",
	"Deselect",
	"Favorite",
	"Open",
	"Select",
	"Swap",
	"ToyTemplates",
	"UnFavorite",
	"View",
	"MenuAndToysNavigation",
}

for _, name in ipairs(ObjectsToRemove) do
	local obj = CloneMenu:FindFirstChild(name)
	if obj then
		obj:Destroy()
	end
end
CloneMenu.Parent = game:GetService("CoreGui") 


local original = game:GetService("Players").LocalPlayer.PlayerGui.MenuGui.TopRight

for _, obj in ipairs(original:GetDescendants()) do
	if obj:IsA("GuiObject") then
		obj.BackgroundTransparency = 1
	end

	if obj:IsA("TextLabel") or obj:IsA("TextButton") or obj:IsA("TextBox") then
		obj.TextTransparency = 1
	end

	if obj:IsA("ImageLabel") or obj:IsA("ImageButton") then
		obj.ImageTransparency = 1
	end

	if obj:IsA("UIStroke") then
		obj.Transparency = 1
	end
end

original.BackgroundTransparency = 1

task.spawn(function()
    
    local Players = game:GetService("Players")
    local RunService = game:GetService("RunService")
    local Stats = game:GetService("Stats")

    local player = Players.LocalPlayer

    -- Оригинальные коины
    local OriginalCoins = player.PlayerGui.MenuGui.TopRight.CoinsFrame.CoinsDisplay.Coins

    -- Клон, куда выводим информацию
    local CloneCoins = game:GetService("CoreGui").CloneMenu.TopRight.CoinsFrame.CoinsDisplay.Coins

    local FPS = 0
    local Frames = 0
    local Ping = 0
    local Time = ""

    task.spawn(function()
        while true do
            task.wait(1)

            FPS = Frames
            Frames = 0

            Ping = math.floor(Stats.Network.ServerStatsItem["Data Ping"]:GetValue())
            Time = os.date("%H:%M:%S")
        end
    end)

    while task.wait(0.1) do
        Frames += 1

        local Coins = OriginalCoins.Text:gsub("%D", "")

        CloneCoins.Text =
            "Coins: " .. Coins ..
            "\nFPS: " .. FPS ..
            "\nPing: " .. Ping .. " ms" ..
            "\nTime: " .. Time
    end
end)
