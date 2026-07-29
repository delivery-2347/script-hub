local Players = game:GetService("Players")
local player = Players.LocalPlayer
local LocalPlayer = player
local Workspace = game:WaitForChild("Workspace")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GrabEvents = ReplicatedStorage:WaitForChild("GrabEvents")

local CreateGrabLine = GrabEvents:WaitForChild("CreateGrabLine")
local DestroyGrabLine = GrabEvents:WaitForChild("DestroyGrabLine")
local FolderSpawnedInToys = LocalPlayer.Name .. "SpawnedInToys"

local Enabledhookmetamethod = true
local seifgrapinfo
local old

--// Values you can change
local Name_name = "Unknown"
local Type_type = "Part"
local Who_spawned = "Player"
local Full_name = "Workspace.Part"

local PlayerNames = {}

for _, plr in ipairs(Players:GetPlayers()) do
    PlayerNames[plr.Name] = true
end

Players.PlayerAdded:Connect(function(plr)
    PlayerNames[plr.Name] = true
end)

Players.PlayerRemoving:Connect(function(plr)
    PlayerNames[plr.Name] = nil
end)

--// GUI

local gui = Instance.new("ScreenGui")
gui.Name = "InfoBox"
gui.ResetOnSpawn = false
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 600, 0, 120) -- длиннее и ниже
frame.Position = UDim2.new(0.5, -275, 0.62, 200) -- ниже центра
frame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
frame.BorderSizePixel = 0
frame.Parent = gui

local distroiButton = Instance.new("TextButton")
distroiButton.Size = UDim2.new(0, 80, 0, 30)
distroiButton.Position = UDim2.new(1, -185, 0.5, -35)
distroiButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
distroiButton.BorderSizePixel = 0
distroiButton.TextColor3 = Color3.fromRGB(255, 255, 255)
distroiButton.TextSize = 14
distroiButton.Font = Enum.Font.Code
distroiButton.Text = "Disconnect"
distroiButton.Parent = frame

local copyName_nameButton = Instance.new("TextButton")
copyName_nameButton.Size = UDim2.new(0, 80, 0, 30)
copyName_nameButton.Position = UDim2.new(1, -95, 0.5, -35)
copyName_nameButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
copyName_nameButton.BorderSizePixel = 0
copyName_nameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyName_nameButton.TextSize = 14
copyName_nameButton.Font = Enum.Font.Code
copyName_nameButton.Text = "Copy name"
copyName_nameButton.Parent = frame

local copyFull_nameButton = Instance.new("TextButton")
copyFull_nameButton.Size = UDim2.new(0, 80, 0, 30)
copyFull_nameButton.Position = UDim2.new(1, -95, 0.5, 5)
copyFull_nameButton.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
copyFull_nameButton.BorderSizePixel = 0
copyFull_nameButton.TextColor3 = Color3.fromRGB(255, 255, 255)
copyFull_nameButton.TextSize = 10
copyFull_nameButton.Font = Enum.Font.Code
copyFull_nameButton.Text = "Copy Full name"
copyFull_nameButton.Parent = frame

local text = Instance.new("TextLabel")
text.Size = UDim2.new(1, -30, 1, -20)
text.Position = UDim2.new(0, 15, 0, 10)
text.BackgroundTransparency = 1
text.TextColor3 = Color3.fromRGB(255,255,255)
text.TextSize = 14
text.Font = Enum.Font.Code
text.TextXAlignment = Enum.TextXAlignment.Left
text.TextYAlignment = Enum.TextYAlignment.Top
text.Parent = frame


--// function

local function Disconnectt()
    Enabledhookmetamethod = false

    if gui then
        gui.Enabled = false
        frame.Visible = false
        gui:Destroy()
        gui = nil
    end
end

distroiButton.MouseButton1Click:Connect(function()
    Disconnectt()
end)

copyName_nameButton.MouseButton1Click:Connect(function()
    if setclipboard then
        if Name_name then
            setclipboard(Name_name)
            copyName_nameButton.Text = "Copied: " .. Name_name
            task.wait(1)
            copyName_nameButton.Text = "Copy name"
        else
            copyName_nameButton.Text = "full name = nil"
        end
    else
        copyName_nameButton.Text = "No Exploit"
    end
end)

copyFull_nameButton.MouseButton1Click:Connect(function()
    if setclipboard then
        if Full_name then
            setclipboard(Full_name)
            copyFull_nameButton.Text = "Copied: " .. Full_name
            task.wait(1)
            copyFull_nameButton.Text = "Copy Full name"
        else
            copyFull_nameButton.Text = "full name = nil"
        end
    else
        copyFull_nameButton.Text = "No Exploit"
    end
end)

local function Update()
    if Name_name == "Model" then Name_name = "Cubes" end
    if Name_name == "YouDecoy" then Name_name = "NPC" end
    if Name_name == "PetTurkeyLeg" then Name_name = "🍗" end
    if Full_name:match("^Workspace%.Map%.AlwaysHereTweenedObjects%.OuterUFO") or Full_name:match("^Workspace%.Map%.AlwaysHereTweenedObjects%.InnerUFO") then Name_name = "UFO" end
    if Full_name:match("^Workspace%.Coin%d+%.SoundPart$") then Name_name = "Coins" end
    local second = string.split(Full_name, ".")[2]
    if second and PlayerNames[second] then Name_name = second end
    text.Text =
		"Name: " .. tostring(Name_name) .. "\n\n" ..
		"Type: " .. tostring(Type_type) .. "\n\n" ..
		"Who spawned: " .. tostring(Who_spawned) .. "\n\n" ..
		"Full name: " .. tostring(Full_name)
end

Update()

--// Example:
-- через секунду меняем значение
task.wait(1)
old = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    if not Enabledhookmetamethod then
        return old(self, ...)
    end
    local args = {...}

    if getnamecallmethod() == "FireServer" then
        if self == CreateGrabLine then
            seifgrapinfo = args[1]:GetFullName()
            Name_name = string.split(args[1]:GetFullName(), ".")[3] 
            Who_spawned = seifgrapinfo:match("^Workspace%.(.-)SpawnedInToys%.") or "GAME"
            Full_name = seifgrapinfo

            Update()
        elseif self == DestroyGrabLine then
            seifgrapinfo = nil
            Update()
        end
    end

    return old(self, ...)
end))
