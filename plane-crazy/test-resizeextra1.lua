-- not my script
-- original thread https://v3rmillion.net/showthread.php?tid=197494

local R15Resize = Instance.new("ScreenGui")
local TextLabel = Instance.new("TextLabel")
local Frame = Instance.new("Frame")
local Run = Instance.new("TextButton")
local BDS = Instance.new("TextLabel")
local BHS = Instance.new("TextLabel")
local BWS = Instance.new("TextLabel")
local HS = Instance.new("TextLabel")
local Title = Instance.new("TextLabel")
local BDSNUM = Instance.new("TextBox")
local BHSNUM = Instance.new("TextBox")
local BWSNUM = Instance.new("TextBox")
local HSNUM = Instance.new("TextBox")
local Player=game:GetService("Players").LocalPlayer
local Character=Player.Character
local Mouse=Player:GetMouse()
local PlayerUI=Player.PlayerGui
local Humanoid=Character.Humanoid
local BodyDepthScale=Humanoid.BodyDepthScale.Value
local BodyHeightScale=Humanoid.BodyHeightScale.Value
local BodyWidthScale=Humanoid.BodyWidthScale.Value
local HeadScale=Humanoid.HeadScale.Value
-- Properties

R15Resize.Name = "R15Resize"
R15Resize.Parent = PlayerUI

TextLabel.Parent = R15Resize
TextLabel.BackgroundColor3 = Color3.new(1, 1, 1)
TextLabel.Draggable = true
TextLabel.Position = UDim2.new(0.709741533, 0, 0.223076925, 0)
TextLabel.Size = UDim2.new(0.0447316095, 0, 0.084615387, 0)
TextLabel.ZIndex = 2
TextLabel.Font = Enum.Font.SourceSans
TextLabel.FontSize = Enum.FontSize.Size14
TextLabel.Text = "Drag me"

Frame.Parent = TextLabel
Frame.BackgroundColor3 = Color3.new(1, 1, 1)
Frame.Position = UDim2.new(0.266666681, 0, 0.878787875, 0)
Frame.Size = UDim2.new(4.62222242, 0, 5.78787899, 0)

Run.Name = "Run"
Run.Parent = Frame
Run.BackgroundColor3 = Color3.new(1, 1, 1)
Run.BorderColor3 = Color3.new(1, 1, 1)
Run.Position = UDim2.new(1.00502515, 0, 0.423312873, 0)
Run.Size = UDim2.new(0.266331673, 0, 0.196319014, 0)
Run.Font = Enum.Font.SourceSans
Run.FontSize = Enum.FontSize.Size14
Run.Text = "Run"

BDS.Name = "BDS="
BDS.Parent = Frame
BDS.BackgroundColor3 = Color3.new(1, 1, 1)
BDS.Position = UDim2.new(0.0313901342, 0, 0.2918455, 0)
BDS.Size = UDim2.new(0.600896835, 0, 0.111587986, 0)
BDS.Font = Enum.Font.SourceSans
BDS.FontSize = Enum.FontSize.Size14
BDS.Text = "BodyDepthScale ="

BHS.Name = "BHS="
BHS.Parent = Frame
BHS.BackgroundColor3 = Color3.new(1, 1, 1)
BHS.Position = UDim2.new(0.0582959652, 0, 0.467811167, 0)
BHS.Size = UDim2.new(0.529147983, 0, 0.150214598, 0)
BHS.Font = Enum.Font.SourceSans
BHS.FontSize = Enum.FontSize.Size14
BHS.Text = "BodyHeightScale"

BWS.Name = "BWS="
BWS.Parent = Frame
BWS.BackgroundColor3 = Color3.new(1, 1, 1)
BWS.Position = UDim2.new(0.0448430479, 0, 0.665236056, 0)
BWS.Size = UDim2.new(0.565022409, 0, 0.14592275, 0)
BWS.Font = Enum.Font.SourceSans
BWS.FontSize = Enum.FontSize.Size14
BWS.Text = "BodyWidthScale"

HS.Name = "HS="
HS.Parent = Frame
HS.BackgroundColor3 = Color3.new(1, 1, 1)
HS.Position = UDim2.new(0.134529144, 0, 0.828326166, 0)
HS.Size = UDim2.new(0.354260087, 0, 0.150214598, 0)
HS.Font = Enum.Font.SourceSans
HS.FontSize = Enum.FontSize.Size14
HS.Text = "HeadScale"

Title.Name = "Title"
Title.Parent = Frame
Title.BackgroundColor3 = Color3.new(1, 1, 1)
Title.Position = UDim2.new(0.0448430479, 0, 0.0300429184, 0)
Title.Size = UDim2.new(0.919282496, 0, 0.214592278, 0)
Title.Font = Enum.Font.SourceSans
Title.FontSize = Enum.FontSize.Size14
Title.Text = "R15 Resize script by CripTiq_C00L ( I TOLD U SO KINDABSOLAM)"
Title.TextWrapped = true

BDSNUM.Name = "BDSNUM"
BDSNUM.Parent = Frame
BDSNUM.BackgroundColor3 = Color3.new(1, 1, 1)
BDSNUM.Position = UDim2.new(0.716346145, 0, 0.287958115, 0)
BDSNUM.Size = UDim2.new(0.105769232, 0, 0.115183249, 0)
BDSNUM.Font = Enum.Font.SourceSans
BDSNUM.FontSize = Enum.FontSize.Size14
BDSNUM.Text = "1"
BDSNUM.TextScaled = true
BDSNUM.TextWrapped = true

BHSNUM.Name = "BHSNUM"
BHSNUM.Parent = Frame
BHSNUM.BackgroundColor3 = Color3.new(1, 1, 1)
BHSNUM.Position = UDim2.new(0.716346145, 0, 0.476439804, 0)
BHSNUM.Size = UDim2.new(0.105769232, 0, 0.115183249, 0)
BHSNUM.Font = Enum.Font.SourceSans
BHSNUM.FontSize = Enum.FontSize.Size14
BHSNUM.Text = "1"
BHSNUM.TextScaled = true
BHSNUM.TextWrapped = true

BWSNUM.Name = "BWSNUM"
BWSNUM.Parent = Frame
BWSNUM.BackgroundColor3 = Color3.new(1, 1, 1)
BWSNUM.Position = UDim2.new(0.716346145, 0, 0.685863853, 0)
BWSNUM.Size = UDim2.new(0.105769232, 0, 0.115183249, 0)
BWSNUM.Font = Enum.Font.SourceSans
BWSNUM.FontSize = Enum.FontSize.Size14
BWSNUM.Text = "1"
BWSNUM.TextScaled = true
BWSNUM.TextWrapped = true

HSNUM.Name = "HSNUM"
HSNUM.Parent = Frame
HSNUM.BackgroundColor3 = Color3.new(1, 1, 1)
HSNUM.Position = UDim2.new(0.716346145, 0, 0.842931926, 0)
HSNUM.Size = UDim2.new(0.105769232, 0, 0.115183249, 0)
HSNUM.Font = Enum.Font.SourceSans
HSNUM.FontSize = Enum.FontSize.Size14
HSNUM.Text = "1"
HSNUM.TextScaled = true
HSNUM.TextWrapped = true
function Clikee()

Humanoid.BodyDepthScale.Value=BDSNUM.Text
Humanoid.BodyHeightScale.Value=BHSNUM.Text
Humanoid.BodyWidthScale.Value=BWSNUM.Text
Humanoid.HeadScale.Value=HSNUM.Text


end
Run.MouseButton1Down:connect(Clikee)
