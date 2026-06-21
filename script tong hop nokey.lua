-- SCRIPT TỔNG HỢP DTEX TỐI ƯU HACK PRO (ROBLOX STUDIO)
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local Camera = workspace.CurrentCamera

-- 1. TẠO SCREEN GUI GỐC
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DTEX_UltimateGui"
ScreenGui.ResetOnSpawn = false
ScreenGui.IgnoreGuiInset = true
ScreenGui.Parent = LocalPlayer:WaitForChild("PlayerGui")

local function makeDraggable(gui)
	local dragging, dragInput, dragStart, startPos
	local function update(input)
		local delta = input.Position - dragStart
		gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end
	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true; dragStart = input.Position; startPos = gui.Position
			input.Changed:Connect(function() if input.UserInputState == Enum.UserInputState.End then dragging = false end end)
		end
	end)
	gui.InputChanged:Connect(function(input) if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end end)
	UserInputService.InputChanged:Connect(function(input) if input == dragInput and dragging then update(input) end end)
end

-- 2. NÚT MỞ / ẨN MENU
local MenuButton = Instance.new("TextButton", ScreenGui)
MenuButton.Size = UDim2.fromScale(0.14, 0.05)
MenuButton.Position = UDim2.new(0.02, 0, 0.15, 0)
MenuButton.BackgroundColor3 = Color3.fromRGB(30, 30, 40)
MenuButton.Text = "Mở Menu"
MenuButton.TextColor3 = Color3.fromRGB(255, 255, 255)
MenuButton.Font = Enum.Font.GothamBold
MenuButton.TextSize = 14
Instance.new("UICorner", MenuButton).CornerRadius = UDim.new(0, 8)
local BtnStroke = Instance.new("UIStroke", MenuButton)
BtnStroke.Color = Color3.fromRGB(0, 170, 255)
BtnStroke.Thickness = 1.5
makeDraggable(MenuButton)

-- 3. KHUNG MENU CHÍNH
local MainFrame = Instance.new("Frame", ScreenGui)
MainFrame.Size = UDim2.fromScale(0.32, 0.6)
MainFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
MainFrame.AnchorPoint = Vector2.new(0.5, 0.5)
MainFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 26)
MainFrame.Visible = false
MainFrame.ClipsDescendants = true
Instance.new("UICorner", MainFrame).CornerRadius = UDim.new(0, 14)
local MainStroke = Instance.new("UIStroke", MainFrame)
MainStroke.Color = Color3.fromRGB(55, 55, 75)
MainStroke.Thickness = 2
makeDraggable(MainFrame)

local AspectRatio = Instance.new("UIAspectRatioConstraint", MainFrame)
AspectRatio.AspectRatio = 0.8

local Title = Instance.new("TextLabel", MainFrame)
Title.Size = UDim2.fromScale(1, 0.12)
Title.BackgroundTransparency = 1
Title.Text = "DTEX TỔNG HỢP VIP"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.GothamBlack
Title.TextSize = 18

local Scroll = Instance.new("ScrollingFrame", MainFrame)
Scroll.Size = UDim2.fromScale(0.9, 0.82)
Scroll.Position = UDim2.new(0.05, 0, 0.15, 0)
Scroll.BackgroundTransparency = 1
Scroll.CanvasSize = UDim2.fromScale(0, 2.3)
Scroll.ScrollBarThickness = 3
Scroll.ScrollBarImageColor3 = Color3.fromRGB(80, 80, 100)

local ListLayout = Instance.new("UIListLayout", Scroll)
ListLayout.SortOrder = Enum.SortOrder.LayoutOrder
ListLayout.Padding = UDim.new(0, 10)

-- HÀM KHỞI TẠO CÁC ROW TIỆN ÍCH
local function createToggle(textLabel, callback)
	local Row = Instance.new("Frame", Scroll)
	Row.Size = UDim2.fromScale(1, 0.07)
	Row.BackgroundTransparency = 1
	local Label = Instance.new("TextLabel", Row)
	Label.Size = UDim2.fromScale(0.65, 1)
	Label.BackgroundTransparency = 1
	Label.Text = textLabel
	Label.TextColor3 = Color3.fromRGB(220, 220, 220)
	Label.Font = Enum.Font.GothamMedium
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	local ToggleBtn = Instance.new("TextButton", Row)
	ToggleBtn.Size = UDim2.fromScale(0.3, 0.9)
	ToggleBtn.Position = UDim2.fromScale(0.7, 0.05)
	ToggleBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
	ToggleBtn.Text = "OFF"
	ToggleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
	ToggleBtn.Font = Enum.Font.GothamBold
	ToggleBtn.TextSize = 12
	Instance.new("UICorner", ToggleBtn).CornerRadius = UDim.new(0, 6)
	local active = false
	local function updateState(state)
		active = state
		if active then
			TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(50, 180, 50)}):Play()
			ToggleBtn.Text = "ON"
		else
			TweenService:Create(ToggleBtn, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(200, 50, 50)}):Play()
			ToggleBtn.Text = "OFF"
		end
		callback(active)
	end
	ToggleBtn.MouseButton1Click:Connect(function() updateState(not active) end)
	return {Set = updateState}
end

local function createStatControl(textLabel, defaultVal, callback)
	local Row = Instance.new("Frame", Scroll)
	Row.Size = UDim2.fromScale(1, 0.07)
	Row.BackgroundTransparency = 1
	local Label = Instance.new("TextLabel", Row)
	Label.Size = UDim2.fromScale(0.4, 1)
	Label.BackgroundTransparency = 1
	Label.Text = textLabel
	Label.TextColor3 = Color3.fromRGB(220, 220, 220)
	Label.Font = Enum.Font.GothamMedium
	Label.TextSize = 13
	Label.TextXAlignment = Enum.TextXAlignment.Left
	local Container = Instance.new("Frame", Row)
	Container.Size = UDim2.fromScale(0.58, 0.9)
	Container.Position = UDim2.fromScale(0.42, 0.05)
	Container.BackgroundTransparency = 1
	local Minus = Instance.new("TextButton", Container)
	Minus.Size = UDim2.fromScale(0.25, 1)
	Minus.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	Minus.Text = "-"
	Minus.TextColor3 = Color3.fromRGB(255, 255, 255)
	Minus.Font = Enum.Font.GothamBold
	Minus.TextSize = 14
	Instance.new("UICorner", Minus).CornerRadius = UDim.new(0, 5)
	local Display = Instance.new("TextLabel", Container)
	Display.Size = UDim2.fromScale(0.5, 1)
	Display.Position = UDim2.fromScale(0.25, 0)
	Display.BackgroundTransparency = 1
	Display.Text = tostring(defaultVal)
	Display.TextColor3 = Color3.fromRGB(0, 170, 255)
	Display.Font = Enum.Font.GothamBold
	Display.TextSize = 14
	local Plus = Instance.new("TextButton", Container)
	Plus.Size = UDim2.fromScale(0.25, 1)
	Plus.Position = UDim2.fromScale(0.75, 0)
	Plus.BackgroundColor3 = Color3.fromRGB(40, 40, 50)
	Plus.Text = "+"
	Plus.TextColor3 = Color3.fromRGB(255, 255, 255)
	Plus.Font = Enum.Font.GothamBold
	Plus.TextSize = 14
	Instance.new("UICorner", Plus).CornerRadius = UDim.new(0, 5)
	local val = defaultVal
	local function setVal(newVal)
		val = math.max(0, newVal)
		Display.Text = tostring(val)
		callback(val)
	end
	Minus.MouseButton1Click:Connect(function() setVal(val - 10) end)
	Plus.MouseButton1Click:Connect(function() setVal(val + 10) end)
	return {Set = setVal}
end

-------------------------------------------------------------------------------
-- LOGIC CÁC CHỨC NĂNG CHÍNH VÀ VIP
-------------------------------------------------------------------------------

-- 1. Tàng Hình Thật (Phá vỡ kết nối FE để người khác hoàn toàn không nhìn thấy bạn)
local isRealInv = false
local savedCharacterParts = {}
local ToggleInv = createToggle("Tàng Hình Thật (FE)", function(state)
	isRealInv = state
	local char = LocalPlayer.Character
	if not char then return end
	local lowerTorso = char:FindFirstChild("LowerTorso") or char:FindFirstChild("Torso")
	local root = char:FindFirstChild("HumanoidRootPart")
	
	if state and root then
		-- Đồng bộ xóa bộ phận gốc chuyển lên server ảo nhân vật bản thân
		for _, v in pairs(char:GetDescendants()) do
			if v:IsA("BasePart") and v.Name ~= "HumanoidRootPart" then
				v.Transparency = 1
			elseif v:IsA("Decal") then
				v.Transparency = 1
			end
		end
		if lowerTorso then
			lowerTorso:BreakJoints() -- Ngắt kết nối khớp xương nhân vật trên server
		end
	elseif not state then
		-- Hồi sinh lại để cơ thể bình thường trở lại
		LocalPlayer: some_method_to_reset() or LocalPlayer.Character:BreakJoints()
	end
end)

-- 2. Nhảy Vô Hạn
local isInfJump = false
local ToggleJump = createToggle("Nhảy Vô Hạn", function(state) isInfJump = state end)
UserInputService.JumpRequest:Connect(function()
	if isInfJump and LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		LocalPlayer.Character:FindFirstChildOfClass("Humanoid"):ChangeState(Enum.HumanoidStateType.Jumping)
	end
end)

-- 3. ESP Định vị Player (Chữ Màu Xanh Lá Cây)
local isESP = false
local espConns = {}
local function createESP(p)
	if p == LocalPlayer then return end
	local function draw(char)
		if not char then return end
		local head = char:WaitForChild("Head", 5)
		if not head then return end
		if head:FindFirstChild("ESP") then head.ESP:Destroy() end
		local bb = Instance.new("BillboardGui", head)
		bb.Name = "ESP"; bb.Size = UDim2.fromOffset(140, 40); bb.StudsOffset = Vector3.new(0, 3, 0); bb.AlwaysOnTop = true
		local lbl = Instance.new("TextLabel", bb)
		lbl.Size = UDim2.fromScale(1, 1); lbl.BackgroundTransparency = 1; lbl.TextColor3 = Color3.fromRGB(0, 255, 100); lbl.Font = Enum.Font.GothamBold; lbl.TextSize = 12
		local hum = char:WaitForChild("Humanoid", 5)
		local loop
		loop = RunService.RenderStepped:Connect(function()
			if not isESP or not char:IsDescendantOf(workspace) or not hum then bb:Destroy(); loop:Disconnect(); return end
			local hp = math.floor((hum.Health / hum.MaxHealth) * 100)
			lbl.Text = p.Name .. " | " .. hp .. "% HP"
		end)
	end
	p.CharacterAdded:Connect(draw)
	if p.Character then draw(p.Character) end
end
local ToggleESP = createToggle("ESP Định Vị (Xanh Lá)", function(state)
	isESP = state
	if state then
		for _, p in pairs(Players:GetPlayers()) do createESP(p) end
		table.insert(espConns, Players.PlayerAdded:Connect(createESP))
	else
		for _, c in pairs(espConns) do c:Disconnect() end; espConns = {}
	end
end)

-- 4. Fly VIP (Bay theo hướng Camera - Lên Trời/Xuống Đất mượt mà)
local isFlying = false
local flySpeed = 50
local ToggleFly = createToggle("Bay VIP (Theo Camera)", function(state)
	isFlying = state
	local char = LocalPlayer.Character
	local root = char and char:FindFirstChild("HumanoidRootPart")
	if not root then return end
	
	if state then
		local bv = Instance.new("BodyVelocity", root)
		bv.Name = "FlyBV"; bv.maxForce = Vector3.new(9e9, 9e9, 9e9); bv.velocity = Vector3.new(0,0,0)
		local bg = Instance.new("BodyGyro", root)
		bg.Name = "FlyBG"; bg.maxTorque = Vector3.new(9e9, 9e9, 9e9); bg.P = 9e4
		
		task.spawn(function()
			while isFlying and root and char:FindFirstChild("HumanoidRootPart") do
				local hum = char:FindFirstChildOfClass("Humanoid")
				if hum then
					-- Bay theo hướng Camera xoay (Xoay lên trời bay lên trời, xoay xuống đất bay xuống đất)
					local dir = Camera.CFrame.LookVector
					if hum.MoveDirection.Magnitude > 0 then
						bv.velocity = dir * flySpeed
					else
						bv.velocity = Vector3.new(0, 0.1, 0)
					end
					bg.cframe = Camera.CFrame
				end
				task.wait()
			end
			if bv then bv:Destroy() end
			if bg then bg:Destroy() end
		end)
	else
		if root:FindFirstChild("FlyBV") then root.FlyBV:Destroy() end
		if root:FindFirstChild("FlyBG") then root.FlyBG:Destroy() end
	end
end)

-- 5. Aimbot VIP (Tự động khóa đầu người chơi gần nhất)
local isAimbot = false
local ToggleAim = createToggle("Aimbot Khóa Đầu (PvP)", function(state)
	isAimbot = state
	if state then
		task.spawn(function()
			while isAimbot do
				local closestPlayer = nil
				local shortestDistance = math.huge
				for _, p in pairs(Players:GetPlayers()) do
					if p ~= LocalPlayer and p.Character and p.Character:FindFirstChild("Head") then
						local dist = (LocalPlayer.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
						if dist < shortestDistance then
							closestPlayer = p
							shortestDistance = dist
						end
					end
				end
				if closestPlayer and closestPlayer.Character then
					Camera.CFrame = CFrame.new(Camera.CFrame.Position, closestPlayer.Character.Head.Position)
				end
				task.wait()
			end
		end)
	end
end)

-- 6. Tính năng Xuyên Tường (Noclip)
local isNoclip = false
local ToggleNoclip = createToggle("Xuyên Tường (Noclip)", function(state)
	isNoclip = state
	if state then
		task.spawn(function()
			while isNoclip and LocalPlayer.Character do
				for _, child in pairs(LocalPlayer.Character:GetDescendants()) do
					if child:IsA("BasePart") then child.CanCollide = false end
				end
				task.wait()
			end
		end)
	end
end)

-- 7. Tính năng Giảm Lag (FPS Booster)
local ToggleLag = createToggle("Giảm Lag (FPS Booster)", function(state)
	if state then
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		for _, v in pairs(workspace:GetDescendants()) do
			if v:IsA("ParticleEmitter") or v:IsA("Trail") or v:IsA("Smoke") or v:IsA("PostEffect") then v.Enabled = false end
		end
	else
		settings().Rendering.QualityLevel = Enum.QualityLevel.Automatic
	end
end)

-- 8. Tăng Speed & Jump Power cơ bản
local walkSpeed = 16
local jumpPower = 50
local SetSpeed = createStatControl("Tốc Độ (Speed)", 16, function(v) walkSpeed = v end)
local SetJump = createStatControl("Sức Nhảy (Jump)", 50, function(v) jumpPower = v end)

RunService.RenderStepped:Connect(function()
	if LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
		local hum = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		hum.WalkSpeed = walkSpeed
		hum.UseJumpPower = true; hum.JumpPower = jumpPower
	end
end)

-------------------------------------------------------------------------------
-- Ô TEXTBOX: TELEPORT & SPECTATE (THEO DÕI POV NGƯỜI KHÁC)
-------------------------------------------------------------------------------
local TeleRow = Instance.new("Frame", Scroll)
TeleRow.Size = UDim2.fromScale(1, 0.08)
TeleRow.BackgroundTransparency = 1

local TextBox = Instance.new("TextBox", TeleRow)
TextBox.Size = UDim2.fromScale(0.45, 0.85)
TextBox.BackgroundColor3 = Color3.fromRGB(35, 35, 45)
TextBox.PlaceholderText = "Nhập tên/3 chữ..."
TextBox.Text = ""
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 11
Instance.new("UICorner", TextBox).CornerRadius = UDim.new(0, 6)

local TeleBtn = Instance.new("TextButton", TeleRow)
TeleBtn.Size = UDim2.fromScale(0.25, 0.85)
TeleBtn.Position = UDim2.fromScale(0.48, 0)
TeleBtn.BackgroundColor3 = Color3.fromRGB(0, 130, 255)
TeleBtn.Text = "Tele"
TeleBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
TeleBtn.Font = Enum.Font.GothamBold
TeleBtn.TextSize = 12
Instance.new("UICorner", TeleBtn).CornerRadius = UDim.new(0, 6)

local SpecBtn = Instance.new("TextButton", TeleRow)
SpecBtn.Size = UDim2.fromScale(0.25, 0.85)
SpecBtn.Position = UDim2.fromScale(0.75, 0)
SpecBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 200)
SpecBtn.Text = "Xem POV"
SpecBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
SpecBtn.Font = Enum.Font.GothamBold
SpecBtn.TextSize = 11
Instance.new("UICorner", SpecBtn).CornerRadius = UDim.new(0, 6)

local function getTargetPlayer()
	local input = string.lower(TextBox.Text)
	if input == "" then return nil end
	for _, p in pairs(Players:GetPlayers()) do
		if p ~= LocalPlayer and string.sub(string.lower(p.Name), 1, #input) == input then
			return p
		end
	end
	return nil
end

TeleBtn.MouseButton1Click:Connect(function()
	local p = getTargetPlayer()
	if p and LocalPlayer.Character and p.Character and p.Character:FindFirstChild("HumanoidRootPart") then
		LocalPlayer.Character.HumanoidRootPart.CFrame = p.Character.HumanoidRootPart.CFrame * CFrame.new(0, 3, 0)
	end
end)

local isSpectating = false
SpecBtn.MouseButton1Click:Connect(function()
	if isSpectating then
		isSpectating = false
		Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		SpecBtn.Text = "Xem POV"
		SpecBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 200)
	else
		local p = getTargetPlayer()
		if p and p.Character and p.Character:FindFirstChildOfClass("Humanoid") then
			isSpectating = true
			Camera.CameraSubject = p.Character:FindFirstChildOfClass("Humanoid")
			SpecBtn.Text = "Hủy POV"
			SpecBtn.BackgroundColor3 = Color3.fromRGB(200, 50, 50)
		end
	end
end)

-------------------------------------------------------------------------------
-- BUTTON RESET ALL
-------------------------------------------------------------------------------
local ResetBtn = Instance.new("TextButton", Scroll)
ResetBtn.Size = UDim2.fromScale(1, 0.08)
ResetBtn.BackgroundColor3 = Color3.fromRGB(210, 120, 0)
ResetBtn.Text = "RESET ALL"
ResetBtn.TextColor3 = Color3.fromRGB(255, 255, 255)
ResetBtn.Font = Enum.Font.GothamBlack
ResetBtn.TextSize = 13
Instance.new("UICorner", ResetBtn).CornerRadius = UDim.new(0, 8)

ResetBtn.MouseButton1Click:Connect(function()
	ToggleInv:Set(false)
	ToggleJump:Set(false)
	ToggleESP:Set(false)
	ToggleFly:Set(false)
	ToggleAim:Set(false)
	ToggleNoclip:Set(false)
	ToggleLag:Set(false)
	SetSpeed(16)
	SetJump(50)
	TextBox.Text = ""
	if isSpectating then
		isSpectating = false
		Camera.CameraSubject = LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
		SpecBtn.Text = "Xem POV"
		SpecBtn.BackgroundColor3 = Color3.fromRGB(130, 50, 200)
	end
end)

-------------------------------------------------------------------------------
-- ANIMATION ĐÓNG MỞ MENU
-------------------------------------------------------------------------------
local isOpen = false
MenuButton.MouseButton1Click:Connect(function()
	isOpen = not isOpen
	if isOpen then
		MenuButton.Text = "Ẩn Menu"; MainFrame.Visible = true; MainFrame.Size = UDim2.fromScale(0, 0); MainFrame.BackgroundTransparency = 1
		TweenService:Create(MainFrame, TweenInfo.new(0.3, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {Size = UDim2.fromScale(0.32, 0.6), BackgroundTransparency = 0}):Play()
	else
		MenuButton.Text = "Mở Menu"
		local closeTween = TweenService:Create(MainFrame, TweenInfo.new(0.2, Enum.EasingStyle.Quad, Enum.EasingDirection.In), {Size = UDim2.fromScale(0, 0), BackgroundTransparency = 1})
		closeTween:Play()
		closeTween.Completed:Connect(function() if not isOpen then MainFrame.Visible = false end end)
	end
end)
