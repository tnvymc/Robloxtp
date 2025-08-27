-- Hizmetler
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local player = Players.LocalPlayer

-- GUI Oluştur
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Parent = game.CoreGui

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0,180,0,140)
Frame.Position = UDim2.new(1, -200, 0, 50) -- sağ üst köşe biraz sola kaydırılmış
Frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
Frame.Parent = ScreenGui

-- Butonlar
local SaveButton = Instance.new("TextButton")
SaveButton.Size = UDim2.new(1,0,0.33,0)
SaveButton.Position = UDim2.new(0,0,0,0)
SaveButton.BackgroundColor3 = Color3.fromRGB(0,170,255)
SaveButton.TextColor3 = Color3.fromRGB(255,255,255)
SaveButton.Text = "Konumu Kaydet"
SaveButton.Parent = Frame

local TPButton = Instance.new("TextButton")
TPButton.Size = UDim2.new(1,0,0.33,0)
TPButton.Position = UDim2.new(0,0,0.33,0)
TPButton.BackgroundColor3 = Color3.fromRGB(0,255,128)
TPButton.TextColor3 = Color3.fromRGB(0,0,0)
TPButton.Text = "Sabit Nokta"
TPButton.Parent = Frame

local NoClipButton = Instance.new("TextButton")
NoClipButton.Size = UDim2.new(1,0,0.34,0)
NoClipButton.Position = UDim2.new(0,0,0.66,0)
NoClipButton.BackgroundColor3 = Color3.fromRGB(255,100,0)
NoClipButton.TextColor3 = Color3.fromRGB(0,0,0)
NoClipButton.Text = "NoClip: Kapalı"
NoClipButton.Parent = Frame

-- Sabit Nokta
local sabitNokta = nil
local noClipActive = false

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

-- NoClip Toggle
NoClipButton.MouseButton1Click:Connect(function()
	noClipActive = not noClipActive
	NoClipButton.Text = "NoClip: " .. (noClipActive and "Açık" or "Kapalı")
end)

-- NoClip uygulama
RunService.Stepped:Connect(function()
	if noClipActive then
		for _, part in pairs(player.Character:GetChildren()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

-- Mobil ve PC sürükleme
local dragging = false
local dragInput
local dragStart
local startPos

Frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = Frame.Position
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

Frame.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.Touch or input.UserInputType == Enum.UserInputType.MouseMovement then
		dragInput = input
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		local delta = input.Position - dragStart
		Frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
