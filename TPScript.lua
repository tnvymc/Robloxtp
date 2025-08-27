-- Hizmetler
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local player = Players.LocalPlayer

-- GUI Oluştur
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,180,0,100)
-- Sağ üst köşe, biraz sola kaydırılmış
Frame.Position = UDim2.new(1, -200, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Parent = ScreenGui

local SaveButton = Instance.new("TextButton")
SaveButton.Size = UDim2.new(1,0,0.5,0)
SaveButton.Position = UDim2.new(0,0,0,0)
SaveButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
SaveButton.TextColor3 = Color3.fromRGB(255,255,255)
SaveButton.Text = "Konumu Kaydet"
SaveButton.Parent = Frame

local TPButton = Instance.new("TextButton")
TPButton.Size = UDim2.new(1,0,0.5,0)
TPButton.Position = UDim2.new(0,0,0.5,0)
TPButton.BackgroundColor3 = Color3.fromRGB(0,255,128)
TPButton.TextColor3 = Color3.fromRGB(0,0,0)
TPButton.Text = "Sabit Nokta"
TPButton.Parent = Frame

-- Sabit Nokta
local sabitNokta = nil

-- HumanoidRootPart alma
local function getHRP()
	local character = player.Character or player.CharacterAdded:Wait()
	return character:WaitForChild("HumanoidRootPart")
end

-- Konumu Kaydet
SaveButton.MouseButton1Click:Connect(function()
	local hrp = getHRP()
	sabitNokta = hrp.Position
	print("Pozisyon kaydedildi: ", sabitNokta)
end)

-- Sabit Nokta Teleport
TPButton.MouseButton1Click:Connect(function()
	if sabitNokta then
		local hrp = getHRP()
		hrp.CFrame = CFrame.new(sabitNokta)
	else
		print("Önce pozisyon kaydedin!")
	end
end)
