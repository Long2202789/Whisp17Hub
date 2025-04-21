-- Whisp17 GUI + AutoFarm bên trong
local ScreenGui = Instance.new("ScreenGui")
local Main = Instance.new("Frame")
local UICorner = Instance.new("UICorner")
local Title = Instance.new("TextLabel")
local AutoFarmBtn = Instance.new("TextButton")
local CloseBtn = Instance.new("TextButton")

ScreenGui.Name = "Whisp17Hub"
ScreenGui.Parent = game.Players.LocalPlayer:WaitForChild("PlayerGui")

Main.Name = "Main"
Main.Parent = ScreenGui
Main.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Main.Position = UDim2.new(0.05, 0, 0.3, 0)
Main.Size = UDim2.new(0, 260, 0, 190)
Main.Active = true
Main.Draggable = true

UICorner.CornerRadius = UDim.new(0, 12)
UICorner.Parent = Main

Title.Name = "Title"
Title.Parent = Main
Title.BackgroundTransparency = 1
Title.Size = UDim2.new(1, 0, 0, 40)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.Text = "💫 Whisp17 Hub"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 22

AutoFarmBtn.Name = "AutoFarmBtn"
AutoFarmBtn.Parent = Main
AutoFarmBtn.BackgroundColor3 = Color3.fromRGB(70, 140, 255)
AutoFarmBtn.Position = UDim2.new(0.1, 0, 0.4, 0)
AutoFarmBtn.Size = UDim2.new(0.8, 0, 0, 40)
AutoFarmBtn.Font = Enum.Font.GothamBold
AutoFarmBtn.Text = "▶️ Auto Farm"
AutoFarmBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
AutoFarmBtn.TextSize = 18

local BtnCorner = Instance.new("UICorner", AutoFarmBtn)
BtnCorner.CornerRadius = UDim.new(0, 8)

CloseBtn.Name = "CloseBtn"
CloseBtn.Parent = Main
CloseBtn.BackgroundColor3 = Color3.fromRGB(255, 70, 70)
CloseBtn.Position = UDim2.new(0.1, 0, 0.7, 0)
CloseBtn.Size = UDim2.new(0.8, 0, 0, 35)
CloseBtn.Font = Enum.Font.Gotham
CloseBtn.Text = "❌ Close"
CloseBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
CloseBtn.TextSize = 16

local BtnCorner2 = Instance.new("UICorner", CloseBtn)
BtnCorner2.CornerRadius = UDim.new(0, 8)

AutoFarmBtn.MouseButton1Click:Connect(function()
    _G.AutoFarm = true
    while _G.AutoFarm do
        wait(0.3)
        pcall(function()
            local player = game.Players.LocalPlayer
            local char = player.Character or player.CharacterAdded:Wait()
            local hrp = char:FindFirstChild("HumanoidRootPart")
            local remote = game:GetService("ReplicatedStorage").Remotes.Combat

            local closest, dist = nil, math.huge
            for _, mob in pairs(workspace.Enemies:GetChildren()) do
                if mob:FindFirstChild("HumanoidRootPart") and mob:FindFirstChild("Humanoid") and mob.Humanoid.Health > 0 then
                    local d = (hrp.Position - mob.HumanoidRootPart.Position).Magnitude
                    if d < dist then
                        closest = mob
                        dist = d
                    end
                end
            end

            if closest then
                hrp.CFrame = closest.HumanoidRootPart.CFrame * CFrame.new(0, 0, 2)
                remote:FireServer("Combat", true)
            end
        end)
    end
end)

CloseBtn.MouseButton1Click:Connect(function()
    ScreenGui:Destroy()
end)
