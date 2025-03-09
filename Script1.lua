local G2L = {};

-- StarterGui.TpExploit
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Name"] = [[TpExploit]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.TpExploit.Frame
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["2"]["Size"] = UDim2.new(0, 100, 0, 100);
G2L["2"]["Position"] = UDim2.new(0.79676, 0, 0.48853, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.TpExploit.Frame.TextButton
G2L["3"] = Instance.new("TextButton", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["TextColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["TextSize"] = 14;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["3"]["FontFace"] = Font.new([[rbxasset://fonts/families/SourceSansPro.json]], Enum.FontWeight.Regular, Enum.FontStyle.Normal);
G2L["3"]["Size"] = UDim2.new(0, 100, 0, 50);
G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["3"]["Position"] = UDim2.new(0, 0, 0.25, 0);


-- StarterGui.TpExploit.Frame.TextButton.LocalScript
G2L["4"] = Instance.new("LocalScript", G2L["3"]);



-- StarterGui.TpExploit.Frame.TextButton.LocalScript
local function C_4()
local script = G2L["4"];
	local Uis = game:GetService("UserInputService")
	local TweenService = game:GetService("TweenService")
	local Camera = game:GetService("Workspace").CurrentCamera
	
	script.Parent.Activated:Connect(function()
			--------------------------------------------------------------------
	
			local char = game.Players.LocalPlayer.Character
			local HumanoidRootPart = char:WaitForChild("HumanoidRootPart")
	
			-- Get the camera's LookVector, but ignore the Y-axis to prevent going into the ground
			local cameraLookVector = Vector3.new(Camera.CFrame.LookVector.X, 0, Camera.CFrame.LookVector.Z)
			local targetPosition = HumanoidRootPart.Position + cameraLookVector * 50  -- Change range to 50 studs
	
			-- Set the character's rotation to match the camera's facing direction
			local targetCFrame = CFrame.new(targetPosition, targetPosition + cameraLookVector)
	
			-- Create the Tween for movement (0.5 seconds duration)
			local TweenInfoMove = TweenInfo.new(
				0.5,  -- Duration of the tween (0.5 second for faster movement)
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out,
				0,  -- Times to repeat (0 means no repetition)
				false,  -- Reverse after the tween ends (false means no reverse)
				0  -- Delay time before the tween starts
			)
	
			local PropertiesMove = {
				CFrame = targetCFrame  -- Move and rotate to the new position and orientation
			}
	
			-- Create the tween for the HumanoidRootPart (movement)
			local TweenMove = TweenService:Create(HumanoidRootPart, TweenInfoMove, PropertiesMove)
	
			-- Create the Tween for rotation (faster rotation - 0.25 second duration)
			local TweenInfoRotate = TweenInfo.new(
				0.25,  -- Faster rotation (0.25 second duration)
				Enum.EasingStyle.Quad,
				Enum.EasingDirection.Out,
				0,  -- Times to repeat (0 means no repetition)
				false,  -- Reverse after the tween ends (false means no reverse)
				0  -- Delay time before the tween starts
			)
	
			local PropertiesRotate = {
				CFrame = targetCFrame  -- Rotate to face the new direction immediately
			}
	
			-- Create the tween for rotation of the HumanoidRootPart
			local TweenRotate = TweenService:Create(HumanoidRootPart, TweenInfoRotate, PropertiesRotate)
	
			-- Play both the movement and rotation tweens
			TweenMove:Play()
			TweenRotate:Play()
		
	end)
	
end;
task.spawn(C_4);

return G2L["1"], require;
