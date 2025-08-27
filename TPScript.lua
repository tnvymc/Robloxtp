-- GUI Oluştur
local ScreenGui = Instance.new("ScreenGui")
local Frame = Instance.new("Frame")
local SaveButton = Instance.new("TextButton")
local TPButton = Instance.new("TextButton")

ScreenGui.Parent = game.CoreGui

Frame.Parent = ScreenGui
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Size = UDim2.new(0, 180, 0, 100)
Frame.Position = UDim2.new(0, 50, 0, 200)

-- Draggable yap
Frame.Active = true
Frame.Draggable = true

-- Konumu Kaydet Butonu
SaveButton.Parent = Frame
SaveButton.Text = "Konumu Kaydet"
SaveButton.Size = UDim2.new(1, 0, 0.5, 0)
SaveButton.BackgroundColor3 = Color3.fromRGB(0, 170, 255)
SaveButton.TextColor3 = Color3.fromRGB(255, 255, 255)

-- Sabit Nokta Butonu
TPButton.Parent = Frame
TPButton.Text = "Sabit Nokta"
TPButton.Size = UDim2.new(1, 0, 0.5, 0)
TPButton.Position = UDim2.new(0, 0, 0.5, 0)
TPButton.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
TPButton.TextColor3 = Color3.fromRGB(0, 0, 0)

-- Sabit Nokta (varsayılan)
local sabitNokta = Vector3.new(0,0,0)

-- Fonksiyonlar
local player = game.Players.LocalPlayer
local function getHRP()
	local character = player.Character or player.CharacterAdded:Wait()
	return character:WaitForChild("HumanoidRootPart")
end

-- Konumu Kaydet
SaveButton.MouseButton1Click:Connect(function()
	local hrp = getHRP()
	sabitNokta = hrp.Position
	print("Şu anki pozisyon kaydedildi: ", sabitNokta)
end)

-- Sabit Nokta TP
TPButton.MouseButton1Click:Connect(function()
	local hrp = getHRP()
	hrp.CFrame = CFrame.new(sabitNokta)
end)
