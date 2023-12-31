local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")
local hoho = {}

function hoho:CreateWindow(hohotitle)
	local hohoUI = Instance.new("ScreenGui")
	local Window = Instance.new("Frame")
	local hohoHubText1 = Instance.new("TextLabel")
	local hohoHubText2 = Instance.new("TextLabel")
	local WindowText = Instance.new("TextLabel")
	local TabWindow = Instance.new("ScrollingFrame")
	local TabWindowList = Instance.new("UIListLayout")
	local ContainerHolder = Instance.new("Frame")

	--Properties:

	hohoUI.Name = "Hoho_Hub"
	hohoUI.Parent = game.Players.LocalPlayer.PlayerGui
	hohoUI.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
	hohoUI.ResetOnSpawn = false
	
	game:GetService("UserInputService").InputBegan:Connect(function(input, chat)
		if not chat and input.KeyCode == Enum.KeyCode.RightControl then
			if game.Players.LocalPlayer.PlayerGui:FindFirstChild("Hoho_Hub").Enabled == true then
				game.Players.LocalPlayer.PlayerGui:FindFirstChild("Hoho_Hub").Enabled = false
			else
				game.Players.LocalPlayer.PlayerGui:FindFirstChild("Hoho_Hub").Enabled = true
			end
		end
	end)

	Window.Name = "Window"
	Window.Parent = hohoUI
	Window.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	Window.BorderSizePixel = 0
	Window.Position = UDim2.new(0, 392, 0, 264)
	Window.Size = UDim2.new(0, 390, 0, 350)
	Instance.new("UICorner",Window)

	hohoHubText1.Name = "HOHO"
	hohoHubText1.Parent = Window
	hohoHubText1.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	hohoHubText1.BackgroundTransparency = 1.000
	hohoHubText1.BorderSizePixel = 0
	hohoHubText1.Position = UDim2.new(0, 5, 0, 0)
	hohoHubText1.Size = UDim2.new(0, 35, 0, 20)
	hohoHubText1.Font = Enum.Font.GothamSemibold
	hohoHubText1.Text = "HOHO"
	hohoHubText1.TextColor3 = Color3.fromRGB(0, 170, 255)
	hohoHubText1.TextSize = 13.000

	hohoHubText2.Name = "Hub"
	hohoHubText2.Parent = Window
	hohoHubText2.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	hohoHubText2.BackgroundTransparency = 1.000
	hohoHubText2.BorderSizePixel = 0
	hohoHubText2.Position = UDim2.new(0, 40, 0, 0)
	hohoHubText2.Size = UDim2.new(0, 35, 0, 20)
	hohoHubText2.Font = Enum.Font.GothamSemibold
	hohoHubText2.Text = "Hub"
	hohoHubText2.TextColor3 = Color3.fromRGB(255, 255, 255)
	hohoHubText2.TextSize = 13.000

	WindowText.Name = "WindowText"
	WindowText.Parent = Window
	WindowText.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
	WindowText.BackgroundTransparency = 1.000
	WindowText.BorderSizePixel = 0
	WindowText.Position = UDim2.new(0, 85, 0, 0)
	WindowText.Size = UDim2.new(0, 305, 0, 20)
	WindowText.Font = Enum.Font.GothamSemibold
	WindowText.Text = "| "..hohotitle or "Game Title"
	WindowText.TextColor3 = Color3.fromRGB(150, 150, 150)
	WindowText.TextSize = 13.000
	WindowText.TextXAlignment = Enum.TextXAlignment.Left

	TabWindow.Name = "TabWindow"
	TabWindow.Parent = Window
	TabWindow.Active = true
	TabWindow.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
	TabWindow.BorderSizePixel = 0
	TabWindow.Position = UDim2.new(0, 7, 0, 20)
	TabWindow.Size = UDim2.new(0, 375, 0, 20)
	TabWindow.CanvasSize = UDim2.new(2, 0, 0, 0)
	TabWindow.ScrollBarThickness = 2
	TabWindow.BackgroundTransparency = 0.3

	TabWindowList.Name = "TabWindowList"
	TabWindowList.Parent = TabWindow
	TabWindowList.FillDirection = Enum.FillDirection.Horizontal
	TabWindowList.SortOrder = Enum.SortOrder.LayoutOrder

	ContainerHolder.Name = "ContainerHolder"
	ContainerHolder.Parent = Window
	ContainerHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
	ContainerHolder.BorderSizePixel = 0
	ContainerHolder.Position = UDim2.new(0, 0, 0, 40)
	ContainerHolder.Size = UDim2.new(0, 390, 0, 200)

	-- Don't Touch This Script Or It Will Mess Up --

	TabWindow.CanvasSize = UDim2.new(0, 0 + TabWindowList.AbsoluteContentSize.X, 0, 0)
	TabWindowList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
		TabWindow.CanvasSize = UDim2.new(0, 0 + TabWindowList.AbsoluteContentSize.X, 0, 0)
	end)

	local gui = Window

	local dragging
	local dragInput
	local dragStart
	local startPos

	local function update(input)
		local delta = input.Position - dragStart
		game:GetService("TweenService"):Create(gui,TweenInfo.new(0.25), {
			Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
		}):Play()
		--gui.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
	end

	gui.InputBegan:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
			dragging = true
			dragStart = input.Position
			startPos = gui.Position

			input.Changed:Connect(function()
				if input.UserInputState == Enum.UserInputState.End then
					dragging = false
				end
			end)
		end
	end)

	gui.InputChanged:Connect(function(input)
		if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
			dragInput = input
		end
	end)

	UserInputService.InputChanged:Connect(function(input)
		if input == dragInput and dragging then
			update(input)
		end
	end)

	local hohoWindow = {}

	function hohoWindow:NewPage(pagetitle)
		local Container = Instance.new("ScrollingFrame")
		local ContainerList = Instance.new("UIListLayout")

		--Properties:

		Container.Name = pagetitle or "Container"
		Container.Parent = ContainerHolder
		Container.Active = true
		Container.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
		Container.BorderSizePixel = 0
		Container.Position = UDim2.new(0, 5, 0, 5)
		Container.Size = UDim2.new(0, 380, 0, 300)
		Container.Visible = false
		Container.CanvasSize = UDim2.new(0, 0, 0, 5 + ContainerList.Padding.Offset + ContainerList.AbsoluteContentSize.Y)
		Container.ScrollBarThickness = 2

		ContainerList.Name = "ContainerList"
		ContainerList.Parent = Container
		ContainerList.HorizontalAlignment = Enum.HorizontalAlignment.Center
		ContainerList.SortOrder = Enum.SortOrder.LayoutOrder
		ContainerList.Padding = UDim.new(0, 5)

		-- Don't Touch This Script Or It Will Mess Up --
		ContainerList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
			Container.CanvasSize = UDim2.new(0, 0, 0, 0 + ContainerList.Padding.Offset + ContainerList.AbsoluteContentSize.Y)
		end)

		Container.ChildAdded:Connect(function()
			Container.CanvasSize = UDim2.new(0, 0, 0, 0 + ContainerList.Padding.Offset + ContainerList.AbsoluteContentSize.Y)
		end)

		local TabButton = Instance.new("TextButton")

		--Properties:

		TabButton.Name = "TabButton"
		TabButton.Parent = TabWindow
		TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.BackgroundTransparency = 1.000
		TabButton.BorderSizePixel = 0
		TabButton.Position = UDim2.new(0, 5, 0, 0)
		TabButton.Size = UDim2.new(0, 100, 0, 20)
		TabButton.Font = Enum.Font.GothamSemibold
		TabButton.Text = pagetitle or "Tab"
		TabButton.TextColor3 = Color3.fromRGB(255, 255, 255)
		TabButton.TextSize = 13.000

		-- Don't Touch This Script Or It Will Mess Up --

		TabButton.Size = UDim2.new(0, 10 + TabButton.TextBounds.X, 0, 20)

		TabButton.MouseButton1Click:Connect(function()
			for _, co in pairs(ContainerHolder:GetChildren()) do
				if co:IsA("ScrollingFrame") then
					co.Visible = false
				end
			end
			for _, tb in pairs(TabWindow:GetChildren()) do
				if tb:IsA("TextButton") then
					TweenService:Create(tb, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
				end
			end
			TweenService:Create(TabButton, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(125, 125, 125)}):Play()
			Container.Visible = true
		end)

		local hohoPage = {}

		function hohoPage:NewSection(sectiontitle)
			local Section = Instance.new("Frame")
			local SectionTitle = Instance.new("TextLabel")
			local SectionIn = Instance.new("Frame")
			local SectionInUICorner = Instance.new("UICorner")
			local SectionInList = Instance.new("UIListLayout")

			--Properties:

			Section.Name = sectiontitle or "Section"
			Section.Parent = Container
			Section.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			Section.Position = UDim2.new(0.0263157897, 0, 0, 0)
			Section.Size = UDim2.new(0, 360, 0, 20)

			SectionTitle.Name = "SectionTitle"
			SectionTitle.Parent = Section
			SectionTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
			SectionTitle.BackgroundTransparency = 1.000
			SectionTitle.BorderSizePixel = 0
			SectionTitle.Size = UDim2.new(0, 360, 0, 15)
			SectionTitle.Font = Enum.Font.GothamSemibold
			SectionTitle.Text = sectiontitle or "Section"
			SectionTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
			SectionTitle.TextSize = 13.000

			SectionIn.Name = "SectionIn"
			SectionIn.Parent = Section
			SectionIn.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
			SectionIn.BorderSizePixel = 0
			SectionIn.Position = UDim2.new(0, 0, 0, 20)
			SectionIn.Size = UDim2.new(0, 360, 0, 70)

			SectionInUICorner.CornerRadius = UDim.new(0, 2)
			SectionInUICorner.Name = "SectionInUICorner"
			SectionInUICorner.Parent = SectionIn

			SectionInList.Name = "SectionInList"
			SectionInList.Parent = SectionIn
			SectionInList.HorizontalAlignment = Enum.HorizontalAlignment.Center
			SectionInList.SortOrder = Enum.SortOrder.LayoutOrder
			SectionInList.Padding = UDim.new(0, 10)

			-- Don't Touch This Script Or It Will Mess Up --

			SectionIn.Size = UDim2.new(0, 360, 0, 5 + SectionInList.AbsoluteContentSize.Y + SectionInList.Padding.Offset)
			SectionInList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				SectionIn.Size = UDim2.new(0, 360, 0, 5 + SectionInList.AbsoluteContentSize.Y + SectionInList.Padding.Offset)
			end)

			local function ContainerSizeChange()
				local largestListSize = 0
				largestListSize = SectionInList.AbsoluteContentSize.Y

				Container.CanvasSize = UDim2.new(0, 0, 0, largestListSize + 35 + SectionInList.Padding.Offset)
			end
			local function sectionsizechange()
				Section.Size = UDim2.new(0, 360, 0, 20 + SectionInList.AbsoluteContentSize.Y + SectionInList.Padding.Offset)
			end
			ContainerSizeChange()
			sectionsizechange()

			SectionInList:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
				ContainerSizeChange()
				sectionsizechange()
			end)

			local hohoElement = {}

			function hohoElement:CreateButton(buttontitle, buttoncallback)
				local ButtonHolder = Instance.new("TextButton")
				local ButtonHolderUICorner = Instance.new("UICorner")
				local ButtonHolderUIStroke = Instance.new("UIStroke")
				local ButtonImage = Instance.new("ImageLabel")

				ButtonHolder.Name = buttontitle or "ButtonHolder"
				ButtonHolder.Parent = SectionIn
				ButtonHolder.BackgroundColor3 = Color3.fromRGB(93, 93, 93)
				ButtonHolder.BorderSizePixel = 0
				ButtonHolder.Position = UDim2.new(0, 5, 0, 0)
				ButtonHolder.Size = UDim2.new(0, 350, 0, 25)
				ButtonHolder.AutoButtonColor = false
				ButtonHolder.Font = Enum.Font.GothamSemibold
				ButtonHolder.Text = buttontitle or "Button | Click Me"
				ButtonHolder.TextColor3 = Color3.fromRGB(255, 255, 255)
				ButtonHolder.TextSize = 13.000

				ButtonHolderUICorner.CornerRadius = UDim.new(0, 4)
				ButtonHolderUICorner.Name = "ButtonHolderUICorner"
				ButtonHolderUICorner.Parent = ButtonHolder

				ButtonHolderUIStroke.Name = "ButtonHolderUIStroke"
				ButtonHolderUIStroke.Parent = ButtonHolder
				ButtonHolderUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				ButtonHolderUIStroke.Color = Color3.fromRGB(221, 221, 221)
				ButtonHolderUIStroke.LineJoinMode = Enum.LineJoinMode.Round
				ButtonHolderUIStroke.Thickness = 1.6
				ButtonHolderUIStroke.Transparency = 0
				ButtonHolderUIStroke.Enabled = true
				ButtonHolderUIStroke.Archivable = true

				ButtonImage.Name = "ButtonImage"
				ButtonImage.Parent = ButtonHolder
				ButtonImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ButtonImage.BackgroundTransparency = 1.000
				ButtonImage.BorderSizePixel = 0
				ButtonImage.Position = UDim2.new(0, 5, 0, 3)
				ButtonImage.Size = UDim2.new(0, 18, 0, 18)
				ButtonImage.Image = "http://www.roblox.com/asset/?id=6034837797"
				ButtonImage.ImageColor3 = Color3.fromRGB(255, 255, 255)

				-- Don't Touch This Script Or It Will Mess Up --

				ButtonHolder.MouseEnter:Connect(function()
					TweenService:Create(ButtonHolder, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(125, 125, 125)}):Play()
					TweenService:Create(ButtonImage, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {ImageColor3 = Color3.fromRGB(125, 125, 125)}):Play()
				end)
				ButtonHolder.MouseLeave:Connect(function()
					TweenService:Create(ButtonHolder, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					TweenService:Create(ButtonImage, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					TweenService:Create(ButtonHolder, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 350, 0, 25)}):Play()
				end)
				ButtonHolder.MouseButton1Down:Connect(function()
					TweenService:Create(ButtonHolder, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 345, 0, 23)}):Play()
				end)
				ButtonHolder.MouseButton1Up:Connect(function()
					TweenService:Create(ButtonHolder, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 350, 0, 25)}):Play()
				end)
				ButtonHolder.MouseButton1Click:Connect(function()
					pcall(function()
						buttoncallback()
					end)
				end)

			end

			function hohoElement:CreateToggle(toggletitle, togglecallback)
				local ToggleHolder = Instance.new("Frame")
				local ToggleHolderUICorner = Instance.new("UICorner")
				local ToggleImage = Instance.new("ImageLabel")
				local ToggleTitle = Instance.new("TextLabel")
				local ToggleOut = Instance.new("ImageLabel")
				local ToggleOutUICorner = Instance.new("UICorner")
				local ToggleIn = Instance.new("ImageLabel")
				local ToggleInUICorner = Instance.new("UICorner")
				local ToggleHolderButton = Instance.new("TextButton")
				local ToggleHolderUIStroke = Instance.new("UIStroke")

				--Properties:

				ToggleHolder.Name = toggletitle or "ToggleHolder"
				ToggleHolder.Parent = SectionIn
				ToggleHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				ToggleHolder.BorderSizePixel = 0
				ToggleHolder.Size = UDim2.new(0, 350, 0, 25)

				ToggleHolderUICorner.CornerRadius = UDim.new(0, 1)
				ToggleHolderUICorner.Name = "ToggleHolderUICorner"
				ToggleHolderUICorner.Parent = ToggleHolder

				ToggleImage.Name = "ToggleImage"
				ToggleImage.Parent = ToggleHolder
				ToggleImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleImage.BackgroundTransparency = 1.000
				ToggleImage.BorderSizePixel = 0
				ToggleImage.Position = UDim2.new(0, 5, 0, 3)
				ToggleImage.Size = UDim2.new(0, 18, 0, 18)
				ToggleImage.Image = "rbxassetid://6034754443"
				ToggleImage.ImageColor3 = Color3.fromRGB(255, 255, 255)

				ToggleTitle.Name = "ToggleTitle"
				ToggleTitle.Parent = ToggleHolder
				ToggleTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleTitle.BackgroundTransparency = 1.000
				ToggleTitle.BorderSizePixel = 0
				ToggleTitle.Position = UDim2.new(0, 25, 0, 0)
				ToggleTitle.Size = UDim2.new(0, 250, 0, 25)
				ToggleTitle.Font = Enum.Font.GothamSemibold
				ToggleTitle.Text = toggletitle or "Toggle | Toggle Me !"
				ToggleTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
				ToggleTitle.TextSize = 13.000
				ToggleTitle.TextXAlignment = Enum.TextXAlignment.Left

				ToggleOut.Name = "ToggleOut"
				ToggleOut.Parent = ToggleHolder
				ToggleOut.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				ToggleOut.Position = UDim2.new(0, 310, 0, 4)
				ToggleOut.Size = UDim2.new(0, 34, 0, 16)
				ToggleOut.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
				ToggleOut.ImageTransparency = 1.000

				ToggleOutUICorner.CornerRadius = UDim.new(0, 1000)
				ToggleOutUICorner.Name = "ToggleOutUICorner"
				ToggleOutUICorner.Parent = ToggleOut

				ToggleIn.Name = "ToggleIn"
				ToggleIn.Parent = ToggleOut
				ToggleIn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleIn.Position = UDim2.new(0, 2, 0, 2)
				ToggleIn.Size = UDim2.new(0, 12, 0, 12)
				ToggleIn.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
				ToggleIn.ImageTransparency = 1.000

				ToggleInUICorner.CornerRadius = UDim.new(0, 1000)
				ToggleInUICorner.Name = "ToggleInUICorner"
				ToggleInUICorner.Parent = ToggleIn

				ToggleHolderButton.Name = "ToggleHolderButton"
				ToggleHolderButton.Parent = ToggleHolder
				ToggleHolderButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				ToggleHolderButton.BackgroundTransparency = 1.000
				ToggleHolderButton.BorderSizePixel = 0
				ToggleHolderButton.Size = UDim2.new(0, 350, 0, 25)
				ToggleHolderButton.ZIndex = 2
				ToggleHolderButton.Font = Enum.Font.SourceSans
				ToggleHolderButton.Text = ""
				ToggleHolderButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				ToggleHolderButton.TextSize = 14.000

				ToggleHolderUIStroke.Name = "ToggleHolderUIStroke"
				ToggleHolderUIStroke.Parent = ToggleHolder
				ToggleHolderUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				ToggleHolderUIStroke.Color = Color3.fromRGB(221, 221, 221)
				ToggleHolderUIStroke.LineJoinMode = Enum.LineJoinMode.Round
				ToggleHolderUIStroke.Thickness = 1.6
				ToggleHolderUIStroke.Transparency = 0
				ToggleHolderUIStroke.Enabled = true
				ToggleHolderUIStroke.Archivable = true

				-- Don't Touch This Script Or It Will Mess Up --

				local toggled = false
				ToggleHolderButton.MouseEnter:Connect(function()
					TweenService:Create(ToggleTitle, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(125, 125, 125)}):Play()
					TweenService:Create(ToggleImage, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {ImageColor3 = Color3.fromRGB(125, 125, 125)}):Play()
				end)
				ToggleHolderButton.MouseLeave:Connect(function()
					TweenService:Create(ToggleTitle, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {TextColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					TweenService:Create(ToggleImage, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {ImageColor3 = Color3.fromRGB(255, 255, 255)}):Play()
					TweenService:Create(ToggleHolder, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 350, 0, 25)}):Play()
				end)
				ToggleHolderButton.MouseButton1Down:Connect(function()
					TweenService:Create(ToggleHolder, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 345, 0, 23)}):Play()
				end)
				ToggleHolderButton.MouseButton1Up:Connect(function()
					TweenService:Create(ToggleHolder, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Size = UDim2.new(0, 350, 0, 25)}):Play()
				end)
				ToggleHolderButton.MouseButton1Click:Connect(function()
					if toggled then
						TweenService:Create(ToggleIn, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 2, 0, 2)}):Play()
						toggled = false
						pcall(function()
							togglecallback(toggled)
						end)
					else
						TweenService:Create(ToggleIn, TweenInfo.new(0.12, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Position = UDim2.new(0, 20, 0, 2)}):Play()
						toggled = true
						pcall(function()
							togglecallback(toggled)
						end)
					end
				end)

			end

			function hohoElement:CreateSlider(slidertitle, minvalue, maxvalue, callback)
				local SliderHolder = Instance.new("Frame")
				local SliderHolderUICorner = Instance.new("UICorner")
				local SliderImage = Instance.new("ImageLabel")
				local SliderHolderTitle = Instance.new("TextLabel")
				local SliderButton = Instance.new("ImageButton")
				local SliderButtonUICorner = Instance.new("UICorner")
				local SliderIn = Instance.new("ImageLabel")
				local SliderInUICorner = Instance.new("UICorner")
				local Val = Instance.new("TextLabel")
				local SliderHolderUIStroke = Instance.new("UIStroke")

				--Properties:

				SliderHolder.Name = slidertitle or "SliderHolder"
				SliderHolder.Parent = SectionIn
				SliderHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				SliderHolder.BorderSizePixel = 0
				SliderHolder.Position = UDim2.new(0, 5, 0, 60)
				SliderHolder.Size = UDim2.new(0, 350, 0, 40)

				SliderHolderUICorner.CornerRadius = UDim.new(0, 1)
				SliderHolderUICorner.Name = "SliderHolderUICorner"
				SliderHolderUICorner.Parent = SliderHolder

				SliderImage.Name = "SliderImage"
				SliderImage.Parent = SliderHolder
				SliderImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderImage.BackgroundTransparency = 1.000
				SliderImage.BorderSizePixel = 0
				SliderImage.Position = UDim2.new(0, 5, 0, 3)
				SliderImage.Size = UDim2.new(0, 18, 0, 18)
				SliderImage.Image = "rbxassetid://6031233840"
				SliderImage.ImageColor3 = Color3.fromRGB(255, 255, 255)

				SliderHolderTitle.Name = "SliderHolderTitle"
				SliderHolderTitle.Parent = SliderHolder
				SliderHolderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderHolderTitle.BackgroundTransparency = 1.000
				SliderHolderTitle.BorderSizePixel = 0
				SliderHolderTitle.Position = UDim2.new(0, 25, 0, 0)
				SliderHolderTitle.Size = UDim2.new(0, 250, 0, 25)
				SliderHolderTitle.Font = Enum.Font.GothamSemibold
				SliderHolderTitle.Text = slidertitle or "Slider | Hold Me !"
				SliderHolderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
				SliderHolderTitle.TextSize = 13.000
				SliderHolderTitle.TextXAlignment = Enum.TextXAlignment.Left

				SliderButton.Name = "SliderButton"
				SliderButton.Parent = SliderHolder
				SliderButton.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				SliderButton.Position = UDim2.new(0, 10, 0, 25)
				SliderButton.Size = UDim2.new(0, 300, 0, 7)
				SliderButton.AutoButtonColor = false
				SliderButton.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
				SliderButton.ImageTransparency = 1.000

				SliderButtonUICorner.CornerRadius = UDim.new(0, 1000)
				SliderButtonUICorner.Name = "SliderButtonUICorner"
				SliderButtonUICorner.Parent = SliderButton

				SliderIn.Name = "SliderIn"
				SliderIn.Parent = SliderButton
				SliderIn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				SliderIn.Size = UDim2.new(0, 0, 0, 7)
				SliderIn.Image = "rbxasset://textures/ui/GuiImagePlaceholder.png"
				SliderIn.ImageTransparency = 1.000

				SliderInUICorner.CornerRadius = UDim.new(0, 1000)
				SliderInUICorner.Name = "SliderInUICorner"
				SliderInUICorner.Parent = SliderIn

				Val.Name = "Val"
				Val.Parent = SliderHolder
				Val.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				Val.BackgroundTransparency = 1.000
				Val.BorderSizePixel = 0
				Val.Position = UDim2.new(0, 282, 0, 0)
				Val.Size = UDim2.new(0, 60, 0, 25)
				Val.Font = Enum.Font.GothamSemibold
				Val.Text = minvalue or "0"
				Val.TextColor3 = Color3.fromRGB(150, 150, 150)
				Val.TextSize = 13.000
				Val.TextXAlignment = Enum.TextXAlignment.Right

				SliderHolderUIStroke.Name = "SliderHolderUIStroke"
				SliderHolderUIStroke.Parent = SliderHolder
				SliderHolderUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				SliderHolderUIStroke.Color = Color3.fromRGB(221, 221, 221)
				SliderHolderUIStroke.LineJoinMode = Enum.LineJoinMode.Round
				SliderHolderUIStroke.Thickness = 1.6
				SliderHolderUIStroke.Transparency = 0
				SliderHolderUIStroke.Enabled = true
				SliderHolderUIStroke.Archivable = true

				minvalue = minvalue or 0
				maxvalue = maxvalue or 100


				-----Callback-----
				callback = callback or function() end


				-----Variables-----
				local mouse = game.Players.LocalPlayer:GetMouse()
				local uis = game:GetService("UserInputService")
				local Value;




				-----Main Code-----

				SliderButton.MouseButton1Down:Connect(function()
					Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 300) * SliderIn.AbsoluteSize.X) + tonumber(minvalue)) or 0
					pcall(function()
						callback(Value)
					end)
					SliderIn.Size = UDim2.new(0, math.clamp(mouse.X - SliderIn.AbsolutePosition.X, 0, 300), 0, 7)
					moveconnection = mouse.Move:Connect(function()
						Val.Text = Value
						Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 300) * SliderIn.AbsoluteSize.X) + tonumber(minvalue))
						pcall(function()
							callback(Value)
						end)
						SliderIn.Size = UDim2.new(0, math.clamp(mouse.X - SliderIn.AbsolutePosition.X, 0, 300), 0, 7)
					end)
					releaseconnection = uis.InputEnded:Connect(function(Mouse)
						if Mouse.UserInputType == Enum.UserInputType.MouseButton1 then
							Value = math.floor((((tonumber(maxvalue) - tonumber(minvalue)) / 300) * SliderIn.AbsoluteSize.X) + tonumber(minvalue))
							pcall(function()
								callback(Value)
							end)
							SliderIn.Size = UDim2.new(0, math.clamp(mouse.X - SliderIn.AbsolutePosition.X, 0, 300), 0, 7)
							moveconnection:Disconnect()
							releaseconnection:Disconnect()
						end
					end)
				end)

			end

			function hohoElement:CreateTextBox(textboxtitle, textboxplaceholdertitle,textboxcallback)
				local TextBoxToggle = Instance.new("Frame")
				local TextBoxToggleUICorner = Instance.new("UICorner")
				local TextBoxImage = Instance.new("ImageLabel")
				local TextBoxTitle = Instance.new("TextLabel")
				local TextBox = Instance.new("TextBox")
				local TextBoxHolderUIStroke = Instance.new("UIStroke")

				--Properties:

				TextBoxToggle.Name = textboxtitle or "TextBoxToggle"
				TextBoxToggle.Parent = SectionIn
				TextBoxToggle.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				TextBoxToggle.BorderSizePixel = 0
				TextBoxToggle.Size = UDim2.new(0, 350, 0, 25)

				TextBoxToggleUICorner.CornerRadius = UDim.new(0, 1)
				TextBoxToggleUICorner.Name = "TextBoxToggleUICorner"
				TextBoxToggleUICorner.Parent = TextBoxToggle

				TextBoxImage.Name = "TextBoxImage"
				TextBoxImage.Parent = TextBoxToggle
				TextBoxImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBoxImage.BackgroundTransparency = 1.000
				TextBoxImage.BorderSizePixel = 0
				TextBoxImage.Position = UDim2.new(0, 5, 0, 3)
				TextBoxImage.Size = UDim2.new(0, 18, 0, 18)
				TextBoxImage.Image = "rbxassetid://6035078890"
				TextBoxImage.ImageColor3 = Color3.fromRGB(255, 255, 255)

				TextBoxTitle.Name = "TextBoxTitle"
				TextBoxTitle.Parent = TextBoxToggle
				TextBoxTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				TextBoxTitle.BackgroundTransparency = 1.000
				TextBoxTitle.BorderSizePixel = 0
				TextBoxTitle.Position = UDim2.new(0, 25, 0, 0)
				TextBoxTitle.Size = UDim2.new(0, 175, 0, 25)
				TextBoxTitle.Font = Enum.Font.GothamSemibold
				TextBoxTitle.Text = textboxtitle or "TextBox"
				TextBoxTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBoxTitle.TextSize = 13.000
				TextBoxTitle.TextXAlignment = Enum.TextXAlignment.Left

				TextBox.Parent = TextBoxToggle
				TextBox.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
				TextBox.BorderSizePixel = 0
				TextBox.Position = UDim2.new(0, 210, 0, 4)
				TextBox.Size = UDim2.new(0, 135, 0, 18)
				TextBox.Font = Enum.Font.GothamSemibold
				TextBox.PlaceholderText = textboxplaceholdertitle or "Enter Text"
				TextBox.Text = ""
				TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
				TextBox.TextSize = 12.000

				TextBoxHolderUIStroke.Name = "TextBoxHolderUIStroke"
				TextBoxHolderUIStroke.Parent = TextBoxToggle
				TextBoxHolderUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				TextBoxHolderUIStroke.Color = Color3.fromRGB(221, 221, 221)
				TextBoxHolderUIStroke.LineJoinMode = Enum.LineJoinMode.Round
				TextBoxHolderUIStroke.Thickness = 1.6
				TextBoxHolderUIStroke.Transparency = 0
				TextBoxHolderUIStroke.Enabled = true
				TextBoxHolderUIStroke.Archivable = true

				TextBox.FocusLost:Connect(function()
					pcall(function()
						textboxcallback(TextBox.Text)
					end)
				end)
			end

			function hohoElement:CreateDropdown(dropdowntitle, list, dropdowncallback)
				list = list or {}

				local DropdownHolder = Instance.new("Frame")
				local DropdownHolderUICorner = Instance.new("UICorner")
				local DropdownImage = Instance.new("ImageLabel")
				local DropdownHolderTitle = Instance.new("TextLabel")
				local DropdownButton = Instance.new("TextButton")
				local DropdownIn = Instance.new("Frame")
				local DropdownInList = Instance.new("UIListLayout")
				local DropdownSelectedTitle = Instance.new("TextLabel")
				local DropdownHolderUIStroke = Instance.new("UIStroke")

				--Properties:

				DropdownHolder.Name = dropdowntitle or "DropdownHolder"
				DropdownHolder.Parent = SectionIn
				DropdownHolder.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
				DropdownHolder.BorderSizePixel = 0
				DropdownHolder.ClipsDescendants = true
				DropdownHolder.Size = UDim2.new(0, 350, 0, 25)

				DropdownHolderUICorner.CornerRadius = UDim.new(0, 1)
				DropdownHolderUICorner.Name = "DropdownHolderUICorner"
				DropdownHolderUICorner.Parent = DropdownHolder

				DropdownImage.Name = "DropdownImage"
				DropdownImage.Parent = DropdownHolder
				DropdownImage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownImage.BackgroundTransparency = 1.000
				DropdownImage.BorderSizePixel = 0
				DropdownImage.Position = UDim2.new(0, 5, 0, 3)
				DropdownImage.Size = UDim2.new(0, 18, 0, 18)
				DropdownImage.Image = "rbxassetid://6026568229"
				DropdownImage.ImageColor3 = Color3.fromRGB(255, 255, 255)

				DropdownHolderTitle.Name = "DropdownHolderTitle"
				DropdownHolderTitle.Parent = DropdownHolder
				DropdownHolderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownHolderTitle.BackgroundTransparency = 1.000
				DropdownHolderTitle.BorderSizePixel = 0
				DropdownHolderTitle.Position = UDim2.new(0, 25, 0, 0)
				DropdownHolderTitle.Size = UDim2.new(0, 175, 0, 25)
				DropdownHolderTitle.Font = Enum.Font.GothamSemibold
				DropdownHolderTitle.Text = dropdowntitle or "Dropdown | Drop Me !"
				DropdownHolderTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownHolderTitle.TextSize = 13.000
				DropdownHolderTitle.TextXAlignment = Enum.TextXAlignment.Left

				DropdownButton.Name = "DropdownButton"
				DropdownButton.Parent = DropdownHolder
				DropdownButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownButton.BackgroundTransparency = 1.000
				DropdownButton.BorderSizePixel = 0
				DropdownButton.Size = UDim2.new(0, 350, 0, 25)
				DropdownButton.ZIndex = 2
				DropdownButton.Font = Enum.Font.SourceSans
				DropdownButton.Text = ""
				DropdownButton.TextColor3 = Color3.fromRGB(0, 0, 0)
				DropdownButton.TextSize = 14.000

				DropdownIn.Name = "DropdownIn"
				DropdownIn.Parent = DropdownHolder
				DropdownIn.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownIn.BackgroundTransparency = 1.000
				DropdownIn.BorderSizePixel = 0
				DropdownIn.Position = UDim2.new(0, 0, 0, 25)
				DropdownIn.Size = UDim2.new(0, 350, 0, 1)

				DropdownInList.Name = "DropdownInList"
				DropdownInList.Parent = DropdownIn
				DropdownInList.SortOrder = Enum.SortOrder.LayoutOrder

				DropdownSelectedTitle.Name = "DropdownSelectedTitle"
				DropdownSelectedTitle.Parent = DropdownHolder
				DropdownSelectedTitle.BackgroundColor3 = Color3.fromRGB(93, 93, 93)
				DropdownSelectedTitle.BorderSizePixel = 0
				DropdownSelectedTitle.Position = UDim2.new(0, 345, 0, 2)
				DropdownSelectedTitle.Size = UDim2.new(0, -50, 0, 20)
				DropdownSelectedTitle.Font = Enum.Font.GothamSemibold
				DropdownSelectedTitle.Text = "NONE"
				DropdownSelectedTitle.TextColor3 = Color3.fromRGB(255, 255, 255)
				DropdownSelectedTitle.TextSize = 12.000

				DropdownHolderUIStroke.Name = "DropdownHolderUIStroke"
				DropdownHolderUIStroke.Parent = TextBoxToggle
				DropdownHolderUIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
				DropdownHolderUIStroke.Color = Color3.fromRGB(221, 221, 221)
				DropdownHolderUIStroke.LineJoinMode = Enum.LineJoinMode.Round
				DropdownHolderUIStroke.Thickness = 1.6
				DropdownHolderUIStroke.Transparency = 0
				DropdownHolderUIStroke.Enabled = true
				DropdownHolderUIStroke.Archivable = true

				-- Don't Touch This Script Or It Will Mess Up --

				DropdownButton.MouseButton1Click:Connect(function()
					DropdownHolder:TweenSize(UDim2.new(0, 350, 0, 25 + DropdownInList.AbsoluteContentSize.Y), "InOut", "Quad", 0.08, true)
				end)

				DropdownSelectedTitle.Size = UDim2.new(0, 0 - DropdownSelectedTitle.TextBounds.X - 5, 0, 20)
				DropdownSelectedTitle:GetPropertyChangedSignal("Text"):Connect(function()
					DropdownSelectedTitle.Size = UDim2.new(0, 0 - DropdownSelectedTitle.TextBounds.X - 5, 0, 20)
				end)

				for listindex, listvalue in next, list do
					local ListButton = Instance.new("TextButton")

					--Properties:

					ListButton.Name = listvalue or "ListButton"
					ListButton.Parent = DropdownIn
					ListButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
					ListButton.BorderSizePixel = 0
					ListButton.Size = UDim2.new(0, 350, 0, 25)
					ListButton.AutoButtonColor = false
					ListButton.Font = Enum.Font.GothamSemibold
					ListButton.Text = listvalue or "List"
					ListButton.TextColor3 = Color3.fromRGB(255, 255, 255)
					ListButton.TextSize = 14.000
					ListButton.BackgroundTransparency = 1

					ListButton.MouseButton1Click:Connect(function()
						DropdownHolder:TweenSize(UDim2.new(0, 350, 0, 25), "InOut", "Quad", 0.08, true)
						DropdownSelectedTitle.Text = ListButton.Text
						pcall(function()
							dropdowncallback(ListButton.Text)
						end)
					end)

				end

				local hohoDropdown = {}

				function hohoDropdown:RefreshDropdown(newlist)
					newlist = newlist or {}
					for _, alllist in pairs(DropdownIn:GetChildren()) do
						if alllist:IsA("TextButton") then
							alllist:Destroy()
						end
					end

					for newlistindex, newlistvalue in next, newlist do
						local ListButton = Instance.new("TextButton")

						--Properties:

						ListButton.Name = newlistvalue or "ListButton"
						ListButton.Parent = DropdownIn
						ListButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
						ListButton.BorderSizePixel = 0
						ListButton.Size = UDim2.new(0, 350, 0, 25)
						ListButton.AutoButtonColor = false
						ListButton.Font = Enum.Font.GothamSemibold
						ListButton.Text = newlistvalue or "List"
						ListButton.TextColor3 = Color3.fromRGB(255, 255, 255)
						ListButton.TextSize = 14.000

						ListButton.MouseButton1Click:Connect(function()
							DropdownHolder:TweenSize(UDim2.new(0, 350, 0, 25), "InOut", "Quad", 0.08, true)
							DropdownSelectedTitle.Text = ListButton.Text
							pcall(function()
								dropdowncallback(ListButton.Text)
							end)
						end)
					end
				end

				return hohoDropdown
			end

			function hohoElement:CreateLabel(labeltitle)
				local DropdownHolderTitle = Instance.new("TextLabel")

				--Properties:

				DropdownHolderTitle.Name = labeltitle or "DropdownHolderTitle"
				DropdownHolderTitle.Parent = SectionIn
				DropdownHolderTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
				DropdownHolderTitle.BackgroundTransparency = 1.000
				DropdownHolderTitle.BorderSizePixel = 0
				DropdownHolderTitle.Position = UDim2.new(0, 5, 0, 190)
				DropdownHolderTitle.Size = UDim2.new(0, 350, 0, 15)
				DropdownHolderTitle.Font = Enum.Font.GothamSemibold
				DropdownHolderTitle.Text = labeltitle or "This Is A Description"
				DropdownHolderTitle.TextColor3 = Color3.fromRGB(150, 150, 150)
				DropdownHolderTitle.TextSize = 13.000
				DropdownHolderTitle.TextXAlignment = Enum.TextXAlignment.Left

				local hohoLabel = {}

				function hohoLabel:ChangeLabel(newlabeltitle)
					DropdownHolderTitle.Text = newlabeltitle
				end

				return hohoLabel
			end

			return hohoElement
		end

		return hohoPage
	end

	return hohoWindow
end

local window = hoho:CreateWindow("云脚本V1.2.6")
local page = window:NewPage("页")
local selection = page:NewSection("选择")
local button = selection:CreateButton("纽扣", function()
	print("Click")
end)
local dr_down = selection:CreateDropdown("滴", {"A","B","C"}, function(sec)
	print(sec)
end)
local sli = selection:CreateSlider("滑块",1,100, function(num)
	print(num)
end)
local textb = selection:CreateTextBox("L", "L", function(text)
	print(text)
end)
local tog = selection:CreateToggle("开关", function(text)
	print(text)
end)
local lab = selection:CreateLabel("关")
