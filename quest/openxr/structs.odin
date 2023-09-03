package openxr


import "core:c"

// Vulkan Types
import vk "vendor:vulkan"

// OpenGL Types
EGLenum :: c.int

// Windows specific OS / API types
when ODIN_OS == .Windows {
	import win32 "core:sys/windows"
        HDC :: win32.HDC
        HGLRC :: win32.HGLRC
	LUID  :: win32.LUID
        IUnknown :: win32.IUnknown

        D3D_FEATURE_LEVEL :: c.int

        import D3D11 "vendor:directx/d3d11"
        ID3D11Device :: D3D11.IDevice
        ID3D11Texture2D :: D3D11.ITexture2D
        
        import D3D12 "vendor:directx/d3d12"
        ID3D12Device :: D3D12.IDevice
        ID3D12CommandQueue :: D3D12.ICommandQueue
        ID3D12Resource :: D3D12.IResource
} else {
        HDC :: distinct rawptr
        HGLRC :: distinct rawptr
	LUID   :: struct {
		LowPart:  DWORD,
		HighPart: LONG,
	}
        IUnknown :: distinct rawptr

        D3D_FEATURE_LEVEL :: c.int
        
        ID3D11Device :: distinct rawptr
        ID3D11Texture2D :: distinct rawptr
        
        ID3D12Device :: distinct rawptr
        ID3D12CommandQueue :: distinct rawptr
        ID3D12Resource :: distinct rawptr
}

Vector2f :: struct {
	x: f32,
	y: f32,
}

Vector3f :: struct {
	x: f32,
	y: f32,
	z: f32,
}

Vector4f :: struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32,
}

Color4f :: struct {
	r: f32,
	g: f32,
	b: f32,
	a: f32,
}

Quaternionf :: struct {
	x: f32,
	y: f32,
	z: f32,
	w: f32,
}

Posef :: struct {
	orientation: Quaternionf,
	position: Vector3f,
}

Offset2Df :: struct {
	x: f32,
	y: f32,
}

Extent2Df :: struct {
	width: f32,
	height: f32,
}

Rect2Df :: struct {
	offset: Offset2Df,
	extent: Extent2Df,
}

Offset2Di :: struct {
	x: i32,
	y: i32,
}

Extent2Di :: struct {
	width: i32,
	height: i32,
}

Rect2Di :: struct {
	offset: Offset2Di,
	extent: Extent2Di,
}

BaseInStructure :: struct {
	sType: StructureType,
	next: ^BaseInStructure,
}

BaseOutStructure :: struct {
	sType: StructureType,
	next: ^BaseOutStructure,
}

ApiLayerProperties :: struct {
	sType: StructureType,
	next: rawptr,
	layerName: [MAX_API_LAYER_NAME_SIZE]u8,
	specVersion: Version,
	layerVersion: u32,
	description: [MAX_API_LAYER_DESCRIPTION_SIZE]u8,
}

ExtensionProperties :: struct {
	sType: StructureType,
	next: rawptr,
	extensionName: [MAX_EXTENSION_NAME_SIZE]u8,
	extensionVersion: u32,
}

ApplicationInfo :: struct {
	applicationName: [MAX_APPLICATION_NAME_SIZE]u8,
	applicationVersion: u32,
	engineName: [MAX_ENGINE_NAME_SIZE]u8,
	engineVersion: u32,
	apiVersion: Version,
}

InstanceCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: InstanceCreateFlags,
	applicationInfo: ApplicationInfo,
	enabledApiLayerCount: u32,
	enabledApiLayerNames: [^]cstring,
	enabledExtensionCount: u32,
	enabledExtensionNames: [^]cstring,
}

InstanceProperties :: struct {
	sType: StructureType,
	next: rawptr,
	runtimeVersion: Version,
	runtimeName: [MAX_RUNTIME_NAME_SIZE]u8,
}

SystemGetInfo :: struct {
	sType: StructureType,
	next: rawptr,
	formFactor: FormFactor,
}

SystemProperties :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	vendorId: u32,
	systemName: [MAX_SYSTEM_NAME_SIZE]u8,
	graphicsProperties: SystemGraphicsProperties,
	trackingProperties: SystemTrackingProperties,
}

SystemGraphicsProperties :: struct {
	maxSwapchainImageHeight: u32,
	maxSwapchainImageWidth: u32,
	maxLayerCount: u32,
}

SystemTrackingProperties :: struct {
	orientationTracking: b32,
	positionTracking: b32,
}

GraphicsBindingOpenGLWin32KHR :: struct {
	sType: StructureType,
	next: rawptr,
	hDC: HDC,
	hGLRC: HGLRC,
}

GraphicsBindingD3D11KHR :: struct {
	sType: StructureType,
	next: rawptr,
	device: ^ID3D11Device,
}

GraphicsBindingD3D12KHR :: struct {
	sType: StructureType,
	next: rawptr,
	device: ^ID3D12Device,
	queue: ^ID3D12CommandQueue,
}

GraphicsBindingVulkanKHR :: struct {
	sType: StructureType,
	next: rawptr,
	instance: vk.Instance,
	physicalDevice: vk.PhysicalDevice,
	device: vk.Device,
	queueFamilyIndex: u32,
	queueIndex: u32,
}

SessionCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: SessionCreateFlags,
	systemId: SystemId,
}

SessionBeginInfo :: struct {
	sType: StructureType,
	next: rawptr,
	primaryViewConfigurationType: ViewConfigurationType,
}

SwapchainCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: SwapchainCreateFlags,
	usageFlags: SwapchainUsageFlags,
	format: i64,
	sampleCount: u32,
	width: u32,
	height: u32,
	faceCount: u32,
	arraySize: u32,
	mipCount: u32,
}

SwapchainImageBaseHeader :: struct {
	sType: StructureType,
	next: rawptr,
}

SwapchainImageOpenGLKHR :: struct {
	sType: StructureType,
	next: rawptr,
	image: u32,
}

SwapchainImageOpenGLESKHR :: struct {
	sType: StructureType,
	next: rawptr,
	image: u32,
}

SwapchainImageVulkanKHR :: struct {
	sType: StructureType,
	next: rawptr,
	image: vk.Image,
}

SwapchainImageD3D11KHR :: struct {
	sType: StructureType,
	next: rawptr,
	texture: ^ID3D11Texture2D,
}

SwapchainImageD3D12KHR :: struct {
	sType: StructureType,
	next: rawptr,
	texture: ^ID3D12Resource,
}

SwapchainImageAcquireInfo :: struct {
	sType: StructureType,
	next: rawptr,
}

SwapchainImageWaitInfo :: struct {
	sType: StructureType,
	next: rawptr,
	timeout: Duration,
}

SwapchainImageReleaseInfo :: struct {
	sType: StructureType,
	next: rawptr,
}

ReferenceSpaceCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	referenceSpaceType: ReferenceSpaceType,
	poseInReferenceSpace: Posef,
}

ActionSpaceCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
	subactionPath: Path,
	poseInActionSpace: Posef,
}

SpaceLocation :: struct {
	sType: StructureType,
	next: rawptr,
	locationFlags: SpaceLocationFlags,
	pose: Posef,
}

SpaceVelocity :: struct {
	sType: StructureType,
	next: rawptr,
	velocityFlags: SpaceVelocityFlags,
	linearVelocity: Vector3f,
	angularVelocity: Vector3f,
}

Fovf :: struct {
	angleLeft: f32,
	angleRight: f32,
	angleUp: f32,
	angleDown: f32,
}

View :: struct {
	sType: StructureType,
	next: rawptr,
	pose: Posef,
	fov: Fovf,
}

ViewLocateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
	displayTime: Time,
	space: Space,
}

ViewState :: struct {
	sType: StructureType,
	next: rawptr,
	viewStateFlags: ViewStateFlags,
}

ViewConfigurationView :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedImageRectWidth: u32,
	maxImageRectWidth: u32,
	recommendedImageRectHeight: u32,
	maxImageRectHeight: u32,
	recommendedSwapchainSampleCount: u32,
	maxSwapchainSampleCount: u32,
}

SwapchainSubImage :: struct {
	swapchain: Swapchain,
	imageRect: Rect2Di,
	imageArrayIndex: u32,
}

CompositionLayerBaseHeader :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
}

CompositionLayerProjectionView :: struct {
	sType: StructureType,
	next: rawptr,
	pose: Posef,
	fov: Fovf,
	subImage: SwapchainSubImage,
}

CompositionLayerProjection :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	viewCount: u32,
	views: ^CompositionLayerProjectionView,
}

CompositionLayerQuad :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	subImage: SwapchainSubImage,
	pose: Posef,
	size: Extent2Df,
}

CompositionLayerCylinderKHR :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	subImage: SwapchainSubImage,
	pose: Posef,
	radius: f32,
	centralAngle: f32,
	aspectRatio: f32,
}

CompositionLayerCubeKHR :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	swapchain: Swapchain,
	imageArrayIndex: u32,
	orientation: Quaternionf,
}

CompositionLayerEquirectKHR :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	subImage: SwapchainSubImage,
	pose: Posef,
	radius: f32,
	scale: Vector2f,
	bias: Vector2f,
}

CompositionLayerDepthInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	subImage: SwapchainSubImage,
	minDepth: f32,
	maxDepth: f32,
	nearZ: f32,
	farZ: f32,
}

FrameBeginInfo :: struct {
	sType: StructureType,
	next: rawptr,
}

FrameEndInfo :: struct {
	sType: StructureType,
	next: rawptr,
	displayTime: Time,
	environmentBlendMode: EnvironmentBlendMode,
	layerCount: u32,
	layers: ^^CompositionLayerBaseHeader,
}

FrameWaitInfo :: struct {
	sType: StructureType,
	next: rawptr,
}

FrameState :: struct {
	sType: StructureType,
	next: rawptr,
	predictedDisplayTime: Time,
	predictedDisplayPeriod: Duration,
	shouldRender: b32,
}

HapticBaseHeader :: struct {
	sType: StructureType,
	next: rawptr,
}

HapticVibration :: struct {
	sType: StructureType,
	next: rawptr,
	duration: Duration,
	frequency: f32,
	amplitude: f32,
}

EventDataBaseHeader :: struct {
	sType: StructureType,
	next: rawptr,
}

EventDataBuffer :: struct {
	sType: StructureType,
	next: rawptr,
	varying: [4000]u8,
}

EventDataEventsLost :: struct {
	sType: StructureType,
	next: rawptr,
	lostEventCount: u32,
}

EventDataInstanceLossPending :: struct {
	sType: StructureType,
	next: rawptr,
	lossTime: Time,
}

EventDataSessionStateChanged :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
	state: SessionState,
	time: Time,
}

EventDataReferenceSpaceChangePending :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
	referenceSpaceType: ReferenceSpaceType,
	changeTime: Time,
	poseValid: b32,
	poseInPreviousSpace: Posef,
}

EventDataPerfSettingsEXT :: struct {
	sType: StructureType,
	next: rawptr,
	domain: PerfSettingsDomainEXT,
	subDomain: PerfSettingsSubDomainEXT,
	fromLevel: PerfSettingsNotificationLevelEXT,
	toLevel: PerfSettingsNotificationLevelEXT,
}

EventDataVisibilityMaskChangedKHR :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
	viewConfigurationType: ViewConfigurationType,
	viewIndex: u32,
}

ViewConfigurationProperties :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
	fovMutable: b32,
}

ActionStateBoolean :: struct {
	sType: StructureType,
	next: rawptr,
	currentState: b32,
	changedSinceLastSync: b32,
	lastChangeTime: Time,
	isActive: b32,
}

ActionStateFloat :: struct {
	sType: StructureType,
	next: rawptr,
	currentState: f32,
	changedSinceLastSync: b32,
	lastChangeTime: Time,
	isActive: b32,
}

ActionStateVector2f :: struct {
	sType: StructureType,
	next: rawptr,
	currentState: Vector2f,
	changedSinceLastSync: b32,
	lastChangeTime: Time,
	isActive: b32,
}

ActionStatePose :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
}

ActionStateGetInfo :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
	subactionPath: Path,
}

HapticActionInfo :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
	subactionPath: Path,
}

ActionSetCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	actionSetName: [MAX_ACTION_SET_NAME_SIZE]u8,
	localizedActionSetName: [MAX_LOCALIZED_ACTION_SET_NAME_SIZE]u8,
	priority: u32,
}

ActionSuggestedBinding :: struct {
	action: Action,
	binding: Path,
}

InteractionProfileSuggestedBinding :: struct {
	sType: StructureType,
	next: rawptr,
	interactionProfile: Path,
	countSuggestedBindings: u32,
	suggestedBindings: ^ActionSuggestedBinding,
}

ActiveActionSet :: struct {
	actionSet: ActionSet,
	subactionPath: Path,
}

SessionActionSetsAttachInfo :: struct {
	sType: StructureType,
	next: rawptr,
	countActionSets: u32,
	actionSets: ^ActionSet,
}

ActionsSyncInfo :: struct {
	sType: StructureType,
	next: rawptr,
	countActiveActionSets: u32,
	activeActionSets: ^ActiveActionSet,
}

BoundSourcesForActionEnumerateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
}

InputSourceLocalizedNameGetInfo :: struct {
	sType: StructureType,
	next: rawptr,
	sourcePath: Path,
	whichComponents: InputSourceLocalizedNameFlags,
}

EventDataInteractionProfileChanged :: struct {
	sType: StructureType,
	next: rawptr,
	session: Session,
}

InteractionProfileState :: struct {
	sType: StructureType,
	next: rawptr,
	interactionProfile: Path,
}

ActionCreateInfo :: struct {
	sType: StructureType,
	next: rawptr,
	actionName: [MAX_ACTION_NAME_SIZE]u8,
	actionType: ActionType,
	countSubactionPaths: u32,
	subactionPaths: ^Path,
	localizedActionName: [MAX_LOCALIZED_ACTION_NAME_SIZE]u8,
}

InstanceCreateInfoAndroidKHR :: struct {
	sType: StructureType,
	next: rawptr,
	applicationVM: rawptr,
	applicationActivity: rawptr,
}

VulkanSwapchainFormatListCreateInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	viewFormatCount: u32,
	viewFormats: ^vk.Format,
}

DebugUtilsObjectNameInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	objectType: ObjectType,
	objectHandle: u64,
	objectName: cstring,
}

DebugUtilsLabelEXT :: struct {
	sType: StructureType,
	next: rawptr,
	labelName: cstring,
}

DebugUtilsMessengerCallbackDataEXT :: struct {
	sType: StructureType,
	next: rawptr,
	messageId: cstring,
	functionName: cstring,
	message: cstring,
	objectCount: u32,
	objects: ^DebugUtilsObjectNameInfoEXT,
	sessionLabelCount: u32,
	sessionLabels: ^DebugUtilsLabelEXT,
}

DebugUtilsMessengerCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	messageSeverities: DebugUtilsMessageSeverityFlagsEXT,
	messageTypes: DebugUtilsMessageTypeFlagsEXT,
	userCallback: ProcDebugUtilsMessengerCallbackEXT,
	userData: rawptr,
}

VisibilityMaskKHR :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector2f,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

GraphicsRequirementsOpenGLKHR :: struct {
	sType: StructureType,
	next: rawptr,
	minApiVersionSupported: Version,
	maxApiVersionSupported: Version,
}

GraphicsRequirementsOpenGLESKHR :: struct {
	sType: StructureType,
	next: rawptr,
	minApiVersionSupported: Version,
	maxApiVersionSupported: Version,
}

GraphicsRequirementsVulkanKHR :: struct {
	sType: StructureType,
	next: rawptr,
	minApiVersionSupported: Version,
	maxApiVersionSupported: Version,
}

GraphicsRequirementsD3D11KHR :: struct {
	sType: StructureType,
	next: rawptr,
	adapterLuid: LUID,
	minFeatureLevel: D3D_FEATURE_LEVEL,
}

GraphicsRequirementsD3D12KHR :: struct {
	sType: StructureType,
	next: rawptr,
	adapterLuid: LUID,
	minFeatureLevel: D3D_FEATURE_LEVEL,
}

VulkanInstanceCreateInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	createFlags: VulkanInstanceCreateFlagsKHR,
	pfnGetInstanceProcAddr: vk.ProcGetInstanceProcAddr,
	vulkanCreateInfo: ^vk.InstanceCreateInfo,
	vulkanAllocator: ^vk.AllocationCallbacks,
}

VulkanDeviceCreateInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	createFlags: VulkanDeviceCreateFlagsKHR,
	pfnGetInstanceProcAddr: vk.ProcGetInstanceProcAddr,
	vulkanPhysicalDevice: vk.PhysicalDevice,
	vulkanCreateInfo: ^vk.DeviceCreateInfo,
	vulkanAllocator: ^vk.AllocationCallbacks,
}

GraphicsBindingVulkan2KHR :: struct {
}

VulkanGraphicsDeviceGetInfoKHR :: struct {
	sType: StructureType,
	next: rawptr,
	systemId: SystemId,
	vulkanInstance: vk.Instance,
}

SwapchainImageVulkan2KHR :: struct {
}

GraphicsRequirementsVulkan2KHR :: struct {
}

VulkanSwapchainCreateInfoMETA :: struct {
	sType: StructureType,
	next: rawptr,
	additionalCreateFlags: vk.ImageCreateFlags,
	additionalUsageFlags: vk.ImageUsageFlags,
}

SessionCreateInfoOverlayEXTX :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: OverlaySessionCreateFlagsEXTX,
	sessionLayersPlacement: u32,
}

EventDataMainSessionVisibilityChangedEXTX :: struct {
	sType: StructureType,
	next: rawptr,
	visible: b32,
	flags: OverlayMainSessionFlagsEXTX,
}

EventDataDisplayRefreshRateChangedFB :: struct {
	sType: StructureType,
	next: rawptr,
	fromDisplayRefreshRate: f32,
	toDisplayRefreshRate: f32,
}

ViewConfigurationDepthRangeEXT :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedNearZ: f32,
	minNearZ: f32,
	recommendedFarZ: f32,
	maxFarZ: f32,
}

ViewConfigurationViewFovEPIC :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedFov: Fovf,
	maxMutableFov: Fovf,
}

InteractionProfileDpadBindingEXT :: struct {
	sType: StructureType,
	next: rawptr,
	binding: Path,
	actionSet: ActionSet,
	forceThreshold: f32,
	forceThresholdReleased: f32,
	centerRegion: f32,
	wedgeAngle: f32,
	isSticky: b32,
	onHaptic: ^HapticBaseHeader,
	offHaptic: ^HapticBaseHeader,
}

InteractionProfileAnalogThresholdVALVE :: struct {
	sType: StructureType,
	next: rawptr,
	action: Action,
	binding: Path,
	onThreshold: f32,
	offThreshold: f32,
	onHaptic: ^HapticBaseHeader,
	offHaptic: ^HapticBaseHeader,
}

BindingModificationsKHR :: struct {
	sType: StructureType,
	next: rawptr,
	bindingModificationCount: u32,
	bindingModifications: ^^BindingModificationBaseHeaderKHR,
}

BindingModificationBaseHeaderKHR :: struct {
	sType: StructureType,
	next: rawptr,
}

SystemEyeGazeInteractionPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	supportsEyeGazeInteraction: b32,
}

EyeGazeSampleTimeEXT :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
}

SpatialAnchorCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	pose: Posef,
	time: Time,
}

SpatialAnchorSpaceCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	anchor: SpatialAnchorMSFT,
	poseInAnchorSpace: Posef,
}

CompositionLayerImageLayoutFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: CompositionLayerImageLayoutFlagsFB,
}

CompositionLayerAlphaBlendFB :: struct {
	sType: StructureType,
	next: rawptr,
	srcFactorColor: BlendFactorFB,
	dstFactorColor: BlendFactorFB,
	srcFactorAlpha: BlendFactorFB,
	dstFactorAlpha: BlendFactorFB,
}

SpatialGraphNodeSpaceCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeType: SpatialGraphNodeTypeMSFT,
	nodeId: [GUID_SIZE_MSFT]u8,
	pose: Posef,
}

SpatialGraphStaticNodeBindingCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	poseInSpace: Posef,
	time: Time,
}

SpatialGraphNodeBindingPropertiesGetInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
}

SpatialGraphNodeBindingPropertiesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeId: [GUID_SIZE_MSFT]u8,
	poseInNodeSpace: Posef,
}

SystemHandTrackingPropertiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	supportsHandTracking: b32,
}

HandTrackerCreateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	hand: HandEXT,
	handJointSet: HandJointSetEXT,
}

HandJointsLocateInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
}

HandJointLocationEXT :: struct {
	locationFlags: SpaceLocationFlags,
	pose: Posef,
	radius: f32,
}

HandJointVelocityEXT :: struct {
	velocityFlags: SpaceVelocityFlags,
	linearVelocity: Vector3f,
	angularVelocity: Vector3f,
}

HandJointLocationsEXT :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
	jointCount: u32,
	jointLocations: ^HandJointLocationEXT,
}

HandJointVelocitiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	jointCount: u32,
	jointVelocities: ^HandJointVelocityEXT,
}

HandJointsMotionRangeInfoEXT :: struct {
	sType: StructureType,
	next: rawptr,
	handJointsMotionRange: HandJointsMotionRangeEXT,
}

HandMeshSpaceCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	handPoseType: HandPoseTypeMSFT,
	poseInHandMeshSpace: Posef,
}

HandMeshUpdateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	time: Time,
	handPoseType: HandPoseTypeMSFT,
}

HandMeshMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
	indexBufferChanged: b32,
	vertexBufferChanged: b32,
	indexBuffer: HandMeshIndexBufferMSFT,
	vertexBuffer: HandMeshVertexBufferMSFT,
}

HandMeshIndexBufferMSFT :: struct {
	indexBufferKey: u32,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

HandMeshVertexBufferMSFT :: struct {
	vertexUpdateTime: Time,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^HandMeshVertexMSFT,
}

HandMeshVertexMSFT :: struct {
	position: Vector3f,
	normal: Vector3f,
}

SystemHandTrackingMeshPropertiesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	supportsHandTrackingMesh: b32,
	maxHandMeshIndexCount: u32,
	maxHandMeshVertexCount: u32,
}

HandPoseTypeInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	handPoseType: HandPoseTypeMSFT,
}

SecondaryViewConfigurationSessionBeginInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationCount: u32,
	enabledViewConfigurationTypes: ^ViewConfigurationType,
}

SecondaryViewConfigurationStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
	active: b32,
}

SecondaryViewConfigurationFrameStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationCount: u32,
	viewConfigurationStates: ^SecondaryViewConfigurationStateMSFT,
}

SecondaryViewConfigurationFrameEndInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationCount: u32,
	viewConfigurationLayersInfo: ^SecondaryViewConfigurationLayerInfoMSFT,
}

SecondaryViewConfigurationLayerInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
	environmentBlendMode: EnvironmentBlendMode,
	layerCount: u32,
	layers: ^^CompositionLayerBaseHeader,
}

SecondaryViewConfigurationSwapchainCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	viewConfigurationType: ViewConfigurationType,
}

HolographicWindowAttachmentMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	holographicSpace: ^IUnknown,
	coreWindow: ^IUnknown,
}

AndroidSurfaceSwapchainCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	createFlags: AndroidSurfaceSwapchainFlagsFB,
}

SwapchainStateBaseHeaderFB :: struct {
	sType: StructureType,
	next: rawptr,
}

SwapchainStateAndroidSurfaceDimensionsFB :: struct {
	sType: StructureType,
	next: rawptr,
	width: u32,
	height: u32,
}

SwapchainStateSamplerOpenGLESFB :: struct {
	sType: StructureType,
	next: rawptr,
	minFilter: EGLenum,
	magFilter: EGLenum,
	wrapModeS: EGLenum,
	wrapModeT: EGLenum,
	swizzleRed: EGLenum,
	swizzleGreen: EGLenum,
	swizzleBlue: EGLenum,
	swizzleAlpha: EGLenum,
	maxAnisotropy: f32,
	borderColor: Color4f,
}

SwapchainStateSamplerVulkanFB :: struct {
	sType: StructureType,
	next: rawptr,
	minFilter: vk.Filter,
	magFilter: vk.Filter,
	mipmapMode: vk.SamplerMipmapMode,
	wrapModeS: vk.SamplerAddressMode,
	wrapModeT: vk.SamplerAddressMode,
	swizzleRed: vk.ComponentSwizzle,
	swizzleGreen: vk.ComponentSwizzle,
	swizzleBlue: vk.ComponentSwizzle,
	swizzleAlpha: vk.ComponentSwizzle,
	maxAnisotropy: f32,
	borderColor: Color4f,
}

CompositionLayerSecureContentFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: CompositionLayerSecureContentFlagsFB,
}

LoaderInitInfoBaseHeaderKHR :: struct {
	sType: StructureType,
	next: rawptr,
}

LoaderInitInfoAndroidKHR :: struct {
	sType: StructureType,
	next: rawptr,
	applicationVM: rawptr,
	applicationContext: rawptr,
}

CompositionLayerEquirect2KHR :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	eyeVisibility: EyeVisibility,
	subImage: SwapchainSubImage,
	pose: Posef,
	radius: f32,
	centralHorizontalAngle: f32,
	upperVerticalAngle: f32,
	lowerVerticalAngle: f32,
}

CompositionLayerColorScaleBiasKHR :: struct {
	sType: StructureType,
	next: rawptr,
	colorScale: Color4f,
	colorBias: Color4f,
}

ControllerModelKeyStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	modelKey: ControllerModelKeyMSFT,
}

ControllerModelNodePropertiesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	parentNodeName: [MAX_CONTROLLER_MODEL_NODE_NAME_SIZE_MSFT]u8,
	nodeName: [MAX_CONTROLLER_MODEL_NODE_NAME_SIZE_MSFT]u8,
}

ControllerModelPropertiesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeCapacityInput: u32,
	nodeCountOutput: u32,
	nodeProperties: ^ControllerModelNodePropertiesMSFT,
}

ControllerModelNodeStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodePose: Posef,
}

ControllerModelStateMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	nodeCapacityInput: u32,
	nodeCountOutput: u32,
	nodeStates: ^ControllerModelNodeStateMSFT,
}

UuidMSFT :: struct {
	bytes: [16]u8,
}

SceneObserverCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
}

SceneCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
}

NewSceneComputeInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	requestedFeatureCount: u32,
	requestedFeatures: ^SceneComputeFeatureMSFT,
	consistency: SceneComputeConsistencyMSFT,
	bounds: SceneBoundsMSFT,
}

VisualMeshComputeLodInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	lod: MeshComputeLodMSFT,
}

SceneSphereBoundMSFT :: struct {
	center: Vector3f,
	radius: f32,
}

SceneOrientedBoxBoundMSFT :: struct {
	pose: Posef,
	extents: Vector3f,
}

SceneFrustumBoundMSFT :: struct {
	pose: Posef,
	fov: Fovf,
	farDistance: f32,
}

SceneBoundsMSFT :: struct {
	space: Space,
	time: Time,
	sphereCount: u32,
	spheres: ^SceneSphereBoundMSFT,
	boxCount: u32,
	boxes: ^SceneOrientedBoxBoundMSFT,
	frustumCount: u32,
	frustums: ^SceneFrustumBoundMSFT,
}

SceneComponentMSFT :: struct {
	componentType: SceneComponentTypeMSFT,
	id: UuidMSFT,
	parentId: UuidMSFT,
	updateTime: Time,
}

SceneComponentsMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	componentCapacityInput: u32,
	componentCountOutput: u32,
	components: ^SceneComponentMSFT,
}

SceneComponentsGetInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	componentType: SceneComponentTypeMSFT,
}

SceneComponentLocationMSFT :: struct {
	flags: SpaceLocationFlags,
	pose: Posef,
}

SceneComponentLocationsMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	locationCount: u32,
	locations: ^SceneComponentLocationMSFT,
}

SceneComponentsLocateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	componentIdCount: u32,
	componentIds: ^UuidMSFT,
}

SceneObjectMSFT :: struct {
	objectType: SceneObjectTypeMSFT,
}

SceneObjectsMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	sceneObjectCount: u32,
	sceneObjects: ^SceneObjectMSFT,
}

SceneComponentParentFilterInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	parentId: UuidMSFT,
}

SceneObjectTypesFilterInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	objectTypeCount: u32,
	objectTypes: ^SceneObjectTypeMSFT,
}

ScenePlaneMSFT :: struct {
	alignment: ScenePlaneAlignmentTypeMSFT,
	size: Extent2Df,
	meshBufferId: u64,
	supportsIndicesUint16: b32,
}

ScenePlanesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	scenePlaneCount: u32,
	scenePlanes: ^ScenePlaneMSFT,
}

ScenePlaneAlignmentFilterInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	alignmentCount: u32,
	alignments: ^ScenePlaneAlignmentTypeMSFT,
}

SceneMeshMSFT :: struct {
	meshBufferId: u64,
	supportsIndicesUint16: b32,
}

SceneMeshesMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	sceneMeshCount: u32,
	sceneMeshes: ^SceneMeshMSFT,
}

SceneMeshBuffersGetInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	meshBufferId: u64,
}

SceneMeshBuffersMSFT :: struct {
	sType: StructureType,
	next: rawptr,
}

SceneMeshVertexBufferMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector3f,
}

SceneMeshIndicesUint32MSFT :: struct {
	sType: StructureType,
	next: rawptr,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u32,
}

SceneMeshIndicesUint16MSFT :: struct {
	sType: StructureType,
	next: rawptr,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^u16,
}

SerializedSceneFragmentDataGetInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	sceneFragmentId: UuidMSFT,
}

DeserializeSceneFragmentMSFT :: struct {
	bufferSize: u32,
	buffer: ^u8,
}

SceneDeserializeInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	fragmentCount: u32,
	fragments: ^DeserializeSceneFragmentMSFT,
}

SystemColorSpacePropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	colorSpace: ColorSpaceFB,
}

SystemSpatialEntityPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsSpatialEntity: b32,
}

SpatialAnchorCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	poseInSpace: Posef,
	time: Time,
}

SpaceComponentStatusSetInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	componentType: SpaceComponentTypeFB,
	enabled: b32,
	timeout: Duration,
}

SpaceComponentStatusFB :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
	changePending: b32,
}

EventDataSpatialAnchorCreateCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
	space: Space,
	uuid: UuidEXT,
}

EventDataSpaceSetStatusCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
	space: Space,
	uuid: UuidEXT,
	componentType: SpaceComponentTypeFB,
	enabled: b32,
}

FoveationProfileCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
}

SwapchainCreateInfoFoveationFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: SwapchainCreateFoveationFlagsFB,
}

SwapchainStateFoveationFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: SwapchainStateFoveationFlagsFB,
	profile: FoveationProfileFB,
}

SwapchainImageFoveationVulkanFB :: struct {
	sType: StructureType,
	next: rawptr,
	image: vk.Image,
	width: u32,
	height: u32,
}

FoveationLevelProfileCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	level: FoveationLevelFB,
	verticalOffset: f32,
	fovDynamic: FoveationDynamicFB,
}

Vector4sFB :: struct {
	x: i16,
	y: i16,
	z: i16,
	w: i16,
}

HandTrackingMeshFB :: struct {
	sType: StructureType,
	next: rawptr,
	jointCapacityInput: u32,
	jointCountOutput: u32,
	jointBindPoses: ^Posef,
	jointRadii: ^f32,
	jointParents: ^HandJointEXT,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertexPositions: ^Vector3f,
	vertexNormals: ^Vector3f,
	vertexUVs: ^Vector2f,
	vertexBlendIndices: ^Vector4sFB,
	vertexBlendWeights: ^Vector4f,
	indexCapacityInput: u32,
	indexCountOutput: u32,
	indices: ^i16,
}

HandTrackingScaleFB :: struct {
	sType: StructureType,
	next: rawptr,
	sensorOutput: f32,
	currentOutput: f32,
	overrideHandScale: b32,
	overrideValueInput: f32,
}

HandTrackingAimStateFB :: struct {
	sType: StructureType,
	next: rawptr,
	status: HandTrackingAimFlagsFB,
	aimPose: Posef,
	pinchStrengthIndex: f32,
	pinchStrengthMiddle: f32,
	pinchStrengthRing: f32,
	pinchStrengthLittle: f32,
}

HandCapsuleFB :: struct {
	points: [HAND_TRACKING_CAPSULE_POINT_COUNT_FB]Vector3f,
	radius: f32,
	joint: HandJointEXT,
}

HandTrackingCapsulesStateFB :: struct {
	sType: StructureType,
	next: rawptr,
	capsules: [HAND_TRACKING_CAPSULE_COUNT_FB]HandCapsuleFB,
}

RenderModelPathInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	path: Path,
}

RenderModelPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	vendorId: u32,
	modelName: [MAX_RENDER_MODEL_NAME_SIZE_FB]u8,
	modelKey: RenderModelKeyFB,
	modelVersion: u32,
	flags: RenderModelFlagsFB,
}

RenderModelBufferFB :: struct {
	sType: StructureType,
	next: rawptr,
	bufferCapacityInput: u32,
	bufferCountOutput: u32,
	buffer: ^u8,
}

RenderModelLoadInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	modelKey: RenderModelKeyFB,
}

SystemRenderModelPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsRenderModelLoading: b32,
}

RenderModelCapabilitiesRequestFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: RenderModelFlagsFB,
}

SpaceQueryInfoBaseHeaderFB :: struct {
	sType: StructureType,
	next: rawptr,
}

SpaceFilterInfoBaseHeaderFB :: struct {
	sType: StructureType,
	next: rawptr,
}

SpaceQueryInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	queryAction: SpaceQueryActionFB,
	maxResultCount: u32,
	timeout: Duration,
	filter: ^SpaceFilterInfoBaseHeaderFB,
	excludeFilter: ^SpaceFilterInfoBaseHeaderFB,
}

SpaceStorageLocationFilterInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	location: SpaceStorageLocationFB,
}

SpaceUuidFilterInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	uuidCount: u32,
	uuids: ^UuidEXT,
}

SpaceComponentFilterInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	componentType: SpaceComponentTypeFB,
}

SpaceQueryResultFB :: struct {
	space: Space,
	uuid: UuidEXT,
}

SpaceQueryResultsFB :: struct {
	sType: StructureType,
	next: rawptr,
	resultCapacityInput: u32,
	resultCountOutput: u32,
	results: ^SpaceQueryResultFB,
}

EventDataSpaceQueryResultsAvailableFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
}

EventDataSpaceQueryCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
}

SpaceSaveInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	location: SpaceStorageLocationFB,
	persistenceMode: SpacePersistenceModeFB,
}

SpaceEraseInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	space: Space,
	location: SpaceStorageLocationFB,
}

EventDataSpaceSaveCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
	space: Space,
	uuid: UuidEXT,
	location: SpaceStorageLocationFB,
}

EventDataSpaceEraseCompleteFB :: struct {
	sType: StructureType,
	next: rawptr,
	requestId: AsyncRequestIdFB,
	result: Result,
	space: Space,
	uuid: UuidEXT,
	location: SpaceStorageLocationFB,
}

SpaceContainerFB :: struct {
	sType: StructureType,
	next: rawptr,
	uuidCapacityInput: u32,
	uuidCountOutput: u32,
	uuids: ^UuidEXT,
}

Extent3DfFB :: struct {
	width: f32,
	height: f32,
	depth: f32,
}

Offset3DfFB :: struct {
	x: f32,
	y: f32,
	z: f32,
}

Rect3DfFB :: struct {
	offset: Offset3DfFB,
	extent: Extent3DfFB,
}

SemanticLabelsFB :: struct {
	sType: StructureType,
	next: rawptr,
	bufferCapacityInput: u32,
	bufferCountOutput: u32,
	buffer: cstring,
}

RoomLayoutFB :: struct {
	sType: StructureType,
	next: rawptr,
	floorUuid: UuidEXT,
	ceilingUuid: UuidEXT,
	wallUuidCapacityInput: u32,
	wallUuidCountOutput: u32,
	wallUuids: ^UuidEXT,
}

Boundary2DFB :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCapacityInput: u32,
	vertexCountOutput: u32,
	vertices: ^Vector2f,
}

SystemKeyboardTrackingPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsKeyboardTracking: b32,
}

KeyboardTrackingDescriptionFB :: struct {
	trackedKeyboardId: u64,
	size: Vector3f,
	flags: KeyboardTrackingFlagsFB,
	name: [MAX_KEYBOARD_TRACKING_NAME_SIZE_FB]u8,
}

KeyboardSpaceCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	trackedKeyboardId: u64,
}

KeyboardTrackingQueryFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: KeyboardTrackingQueryFlagsFB,
}

CompositionLayerDepthTestVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	depthTestRangeNearZ: f32,
	depthTestRangeFarZ: f32,
}

ViewLocateFoveatedRenderingVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	foveatedRenderingActive: b32,
}

FoveatedViewConfigurationViewVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	foveatedRenderingActive: b32,
}

SystemFoveatedRenderingPropertiesVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	supportsFoveatedRendering: b32,
}

CompositionLayerReprojectionInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	reprojectionMode: ReprojectionModeMSFT,
}

CompositionLayerReprojectionPlaneOverrideMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	position: Vector3f,
	normal: Vector3f,
	velocity: Vector3f,
}

TriangleMeshCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: TriangleMeshFlagsFB,
	windingOrder: WindingOrderFB,
	vertexCount: u32,
	vertexBuffer: ^Vector3f,
	triangleCount: u32,
	indexBuffer: ^u32,
}

SystemPassthroughPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	supportsPassthrough: b32,
}

SystemPassthroughProperties2FB :: struct {
	sType: StructureType,
	next: rawptr,
	capabilities: PassthroughCapabilityFlagsFB,
}

PassthroughCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: PassthroughFlagsFB,
}

PassthroughLayerCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	passthrough: PassthroughFB,
	flags: PassthroughFlagsFB,
	purpose: PassthroughLayerPurposeFB,
}

CompositionLayerPassthroughFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: CompositionLayerFlags,
	space: Space,
	layerHandle: PassthroughLayerFB,
}

GeometryInstanceCreateInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	layer: PassthroughLayerFB,
	mesh: TriangleMeshFB,
	baseSpace: Space,
	pose: Posef,
	scale: Vector3f,
}

GeometryInstanceTransformFB :: struct {
	sType: StructureType,
	next: rawptr,
	baseSpace: Space,
	time: Time,
	pose: Posef,
	scale: Vector3f,
}

PassthroughStyleFB :: struct {
	sType: StructureType,
	next: rawptr,
	textureOpacityFactor: f32,
	edgeColor: Color4f,
}

PassthroughColorMapMonoToRgbaFB :: struct {
	sType: StructureType,
	next: rawptr,
	textureColorMap: [PASSTHROUGH_COLOR_MAP_MONO_SIZE_FB]Color4f,
}

PassthroughColorMapMonoToMonoFB :: struct {
	sType: StructureType,
	next: rawptr,
	textureColorMap: [PASSTHROUGH_COLOR_MAP_MONO_SIZE_FB]u8,
}

PassthroughBrightnessContrastSaturationFB :: struct {
	sType: StructureType,
	next: rawptr,
	brightness: f32,
	contrast: f32,
	saturation: f32,
}

EventDataPassthroughStateChangedFB :: struct {
	sType: StructureType,
	next: rawptr,
	flags: PassthroughStateChangedFlagsFB,
}

PassthroughKeyboardHandsIntensityFB :: struct {
	sType: StructureType,
	next: rawptr,
	leftHandIntensity: f32,
	rightHandIntensity: f32,
}

SpatialAnchorPersistenceNameMSFT :: struct {
	name: [MAX_SPATIAL_ANCHOR_NAME_SIZE_MSFT]u8,
}

SpatialAnchorPersistenceInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	spatialAnchorPersistenceName: SpatialAnchorPersistenceNameMSFT,
	spatialAnchor: SpatialAnchorMSFT,
}

SpatialAnchorFromPersistedAnchorCreateInfoMSFT :: struct {
	sType: StructureType,
	next: rawptr,
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
	spatialAnchorPersistenceName: SpatialAnchorPersistenceNameMSFT,
}

FacialTrackerCreateInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	facialTrackingType: FacialTrackingTypeHTC,
}

SystemFacialTrackingPropertiesHTC :: struct {
	sType: StructureType,
	next: rawptr,
	supportEyeFacialTracking: b32,
	supportLipFacialTracking: b32,
}

FacialExpressionsHTC :: struct {
	sType: StructureType,
	next: rawptr,
	isActive: b32,
	sampleTime: Time,
	expressionCount: u32,
	expressionWeightings: ^f32,
}

PassthroughCreateInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	form: PassthroughFormHTC,
}

PassthroughColorHTC :: struct {
	sType: StructureType,
	next: rawptr,
	alpha: f32,
}

PassthroughMeshTransformInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	vertexCount: u32,
	vertices: ^Vector3f,
	indexCount: u32,
	indices: ^u32,
	baseSpace: Space,
	time: Time,
	pose: Posef,
	scale: Vector3f,
}

CompositionLayerPassthroughHTC :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerFlags,
	space: Space,
	passthrough: PassthroughHTC,
	color: PassthroughColorHTC,
}

ViveTrackerPathsHTCX :: struct {
	sType: StructureType,
	next: rawptr,
	persistentPath: Path,
	rolePath: Path,
}

EventDataViveTrackerConnectedHTCX :: struct {
	sType: StructureType,
	next: rawptr,
	paths: ^ViveTrackerPathsHTCX,
}

CompositionLayerSpaceWarpInfoFB :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerSpaceWarpInfoFlagsFB,
	motionVectorSubImage: SwapchainSubImage,
	appSpaceDeltaPose: Posef,
	depthSubImage: SwapchainSubImage,
	minDepth: f32,
	maxDepth: f32,
	nearZ: f32,
	farZ: f32,
}

SystemSpaceWarpPropertiesFB :: struct {
	sType: StructureType,
	next: rawptr,
	recommendedMotionVectorImageRectWidth: u32,
	recommendedMotionVectorImageRectHeight: u32,
}

SystemMarkerTrackingPropertiesVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	supportsMarkerTracking: b32,
}

EventDataMarkerTrackingUpdateVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	markerId: u64,
	isActive: b32,
	isPredicted: b32,
	time: Time,
}

MarkerSpaceCreateInfoVARJO :: struct {
	sType: StructureType,
	next: rawptr,
	markerId: u64,
	poseInMarkerSpace: Posef,
}

UuidEXT :: struct {
	data: [UUID_SIZE_EXT]u8,
}

DigitalLensControlALMALENCE :: struct {
	sType: StructureType,
	next: rawptr,
	flags: DigitalLensControlFlagsALMALENCE,
}

CompositionLayerSettingsFB :: struct {
	sType: StructureType,
	next: rawptr,
	layerFlags: CompositionLayerSettingsFlagsFB,
}

PerformanceMetricsStateMETA :: struct {
	sType: StructureType,
	next: rawptr,
	enabled: b32,
}

PerformanceMetricsCounterMETA :: struct {
	sType: StructureType,
	next: rawptr,
	counterFlags: PerformanceMetricsCounterFlagsMETA,
	counterUnit: PerformanceMetricsCounterUnitMETA,
	uintValue: u32,
	floatValue: f32,
}

SystemHeadsetIdPropertiesMETA :: struct {
	sType: StructureType,
	next: rawptr,
	id: UuidEXT,
}

FoveationApplyInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	mode: FoveationModeHTC,
	subImageCount: u32,
	subImages: ^SwapchainSubImage,
}

FoveationConfigurationHTC :: struct {
	level: FoveationLevelHTC,
	clearFovDegree: f32,
	focalCenterOffset: Vector2f,
}

FoveationDynamicModeInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	dynamicFlags: FoveationDynamicFlagsHTC,
}

FoveationCustomModeInfoHTC :: struct {
	sType: StructureType,
	next: rawptr,
	configCount: u32,
	configs: ^FoveationConfigurationHTC,
}

ActiveActionSetPrioritiesEXT :: struct {
	sType: StructureType,
	next: rawptr,
	actionSetPriorityCount: u32,
	actionSetPriorities: ^ActiveActionSetPriorityEXT,
}

ActiveActionSetPriorityEXT :: struct {
	actionSet: ActionSet,
	priorityOverride: u32,
}

