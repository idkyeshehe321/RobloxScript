local G2L = {};

-- StarterGui.TeleportGui
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[TeleportGui]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

-- StarterGui.TeleportGui.ScrollingFrame
G2L["2"] = Instance.new("ScrollingFrame", G2L["1"]);
G2L["2"]["Active"] = true;
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["CanvasSize"] = UDim2.new(0, 0, 0, 0);
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2"]["Size"] = UDim2.new(0, 200, 0, 300);
G2L["2"]["ScrollBarImageColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["Position"] = UDim2.new(0.08429, -100, 0.5, -150);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);

-- StarterGui.TeleportGui.ScrollingFrame.UIListLayout
G2L["3"] = Instance.new("UIListLayout", G2L["2"]);
G2L["3"]["SortOrder"] = Enum.SortOrder.LayoutOrder;

-- StarterGui.TeleportGui.LocalScript
G2L["4"] = Instance.new("LocalScript", G2L["1"]);

-- StarterGui.TpExploit
G2L["5"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["5"]["Name"] = [[TpExploit]];
G2L["5"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;

-- StarterGui.TpExploit.Frame
G2L["6"] = Instance.new("Frame", G2L["5"]);
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["6"]["Position"] = UDim2.new(0.79676, 0, 0.48853, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);

-- StarterGui.TpExploit.Frame.TextButton
G2L["7"] = Instance.new("TextButton", G2L["6"]);
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["TextSize"] = 14;
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["7"]["Size"] = UDim2.new(0, 100, 0, 50);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Position"] = UDim2.new(0, 0, 0.25, 0);

-- StarterGui.TpExploit.Frame.TextButton.LocalScript
G2L["8"] = Instance.new("LocalScript", G2L["7"]);

-- Function for TeleportGui
local function C_4_TeleportGui()
	local script = G2L["4"];
	local Players = game:GetService("Players");
	local TweenService = game:GetService("TweenService");

	local player = Players.LocalPlayer;
	local screenGui = script.Parent;
	local scrollFrame = screenGui:WaitForChild("ScrollingFrame");

	local function updateCanvasSize()
		scrollFrame.CanvasSize = UDim2.new(0, 0, 0, scrollFrame.UIListLayout.AbsoluteContentSize.Y + 10);
	end

	-- Function to create a player button
	local function createPlayerButton(targetPlayer)
		if targetPlayer == player then return end  -- Don't add yourself

		local button = Instance.new("TextButton");
		button.Size = UDim2.new(1, 0, 0, 50);
		button.Text = targetPlayer.Name;
		button.Parent = scrollFrame;
		button.BackgroundColor3 = Color3.fromRGB(30, 30, 30);
		button.TextColor3 = Color3.fromRGB(255, 255, 255);
		button.Font = Enum.Font.SourceSansBold;
		button.TextSize = 16;

		-- Teleport behind the player when clicked
		button.MouseButton1Click:Connect(function()
			local char = player.Character;
			local targetChar = targetPlayer.Character;
			if char and targetChar and targetChar:FindFirstChild("HumanoidRootPart") then
				local hrp = char:FindFirstChild("HumanoidRootPart");
				local targetHRP = targetChar:FindFirstChild("HumanoidRootPart");

				if hrp then
					-- Calculate position behind the target player
					local targetPos = targetHRP.Position - (targetHRP.CFrame.LookVector * 5);

					-- Use CFrame to set new position, keeping the original rotation
					local newCFrame = CFrame.new(targetPos, targetHRP.Position);

					-- Use a tween to smoothly move the player's HumanoidRootPart
					local tweenInfo = TweenInfo.new(
						0.5,  -- Duration (0.5 sec)
						Enum.EasingStyle.Quad,  -- Easing style
						Enum.EasingDirection.Out  -- Easing direction
					);

					local goal = {CFrame = newCFrame};
					local tween = TweenService:Create(hrp, tweenInfo, goal);
					tween:Play();
				end
			end
		end);

		updateCanvasSize();
	end

	-- Populate the list with all current players
	for _, otherPlayer in pairs(Players:GetPlayers()) do
		createPlayerButton(otherPlayer);
	end

	-- Update when new players join
	Players.PlayerAdded:Connect(createPlayerButton);

	-- Remove player button when someone leaves
	Players.PlayerRemoving:Connect(function(leavingPlayer)
		for _, button in pairs(scrollFrame:GetChildren()) do
			if button:IsA("TextButton") and button.Text == leavingPlayer.Name then
				button:Destroy();
			end
		end
		updateCanvasSize();
	end);

	-- Update scrolling when UI changes
	scrollFrame.UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvasSize);
end;

-- Function for TpExploit
local function C_4_TpExploit()
	local script = G2L["8"];
	local Uis = game:GetService("UserInputService");
	local TweenService = game:GetService("TweenService");
	local Camera = game:GetService("Workspace").CurrentCamera;

	script.Parent.Activated:Connect(function()
		local char = game.Players.LocalPlayer.Character;
		local HumanoidRootPart = char:WaitForChild("HumanoidRootPart");

		-- Get the camera's LookVector, but ignore the Y-axis to prevent going into the ground
		local cameraLookVector = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z);
		local targetPosition = HumanoidRootPart.Position + cameraLookVector * 50  -- Change range to 50 studs

		-- Set the character's rotation to match the camera's facing direction
		local targetCFrame = CFrame.new(targetPosition, targetPosition + cameraLookVector);

		-- Create the Tween for movement (0.5 seconds duration)
		local TweenInfoMove = TweenInfo.new(
			0.5,  -- Duration of the tween (0.5 second for faster movement)
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out,
			0,  -- Times to repeat (0 means no repetition)
			false,  -- Reverse after the tween ends (false means no reverse)
			0  -- Delay time before the tween starts
		);

		local PropertiesMove = {
			CFrame = targetCFrame  -- Move and rotate to the new position and orientation
		};

		-- Create the tween for the HumanoidRootPart (movement)
		local TweenMove = TweenService:Create(HumanoidRootPart, TweenInfoMove, PropertiesMove);

		-- Create the Tween for rotation (faster rotation - 0.25 second duration)
		local TweenInfoRotate = TweenInfo.new(
			0.25,  -- Faster rotation (0.25 second duration)
			Enum.EasingStyle.Quad,
			Enum.EasingDirection.Out,
			0,  -- Times to repeat (0 means no repetition)
			false,  -- Reverse after the tween ends (false means no reverse)
			0  -- Delay time before the tween starts
		);

		local PropertiesRotate = {
			CFrame = targetCFrame  -- Rotate to face the new direction immediately
		};

		-- Create the tween for rotation of the HumanoidRootPart
		local TweenRotate = TweenService:Create(HumanoidRootPart, TweenInfoRotate, PropertiesRotate);

		-- Play both the movement and rotation tweens
		TweenMove:Play();
		TweenRotate:Play();
	end);
end;

task.spawn(C_4_TeleportGui);
task.spawn(C_4_TpExploit);

return G2L["1"], require;
