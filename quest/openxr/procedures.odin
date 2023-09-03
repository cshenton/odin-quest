package openxr


import "core:c"
import "core:c/libc"

// Vulkan Types
import vk "vendor:vulkan"

timespec :: libc.timespec
wchar_t :: libc.wchar_t
jobject :: rawptr

when ODIN_OS == .Windows {
	import win32 "core:sys/windows"
        LARGE_INTEGER :: win32.LARGE_INTEGER
} else {
        LARGE_INTEGER :: distinct c.longlong
}

ProcEnumerateApiLayerProperties :: #type proc "system" (
	propertyCapacityInput: u32,
	propertyCountOutput: ^u32,
	properties: ^ApiLayerProperties,
) -> Result

ProcEnumerateInstanceExtensionProperties :: #type proc "system" (
	layerName: cstring,
	propertyCapacityInput: u32,
	propertyCountOutput: ^u32,
	properties: ^ExtensionProperties,
) -> Result

ProcCreateInstance :: #type proc "system" (
	createInfo: ^InstanceCreateInfo,
	instance: ^Instance,
) -> Result

ProcDestroyInstance :: #type proc "system" (
	instance: Instance,
) -> Result

ProcResultToString :: #type proc "system" (
	instance: Instance,
	value: Result,
	buffer: [^]u8,
) -> Result

ProcStructureTypeToString :: #type proc "system" (
	instance: Instance,
	value: StructureType,
	buffer: [^]u8,
) -> Result

ProcGetInstanceProperties :: #type proc "system" (
	instance: Instance,
	instanceProperties: ^InstanceProperties,
) -> Result

ProcGetSystem :: #type proc "system" (
	instance: Instance,
	getInfo: ^SystemGetInfo,
	systemId: ^SystemId,
) -> Result

ProcGetSystemProperties :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	properties: ^SystemProperties,
) -> Result

ProcCreateSession :: #type proc "system" (
	instance: Instance,
	createInfo: ^SessionCreateInfo,
	session: ^Session,
) -> Result

ProcDestroySession :: #type proc "system" (
	session: Session,
) -> Result

ProcDestroySpace :: #type proc "system" (
	space: Space,
) -> Result

ProcEnumerateSwapchainFormats :: #type proc "system" (
	session: Session,
	formatCapacityInput: u32,
	formatCountOutput: ^u32,
	formats: ^i64,
) -> Result

ProcCreateSwapchain :: #type proc "system" (
	session: Session,
	createInfo: ^SwapchainCreateInfo,
	swapchain: ^Swapchain,
) -> Result

ProcDestroySwapchain :: #type proc "system" (
	swapchain: Swapchain,
) -> Result

ProcEnumerateSwapchainImages :: #type proc "system" (
	swapchain: Swapchain,
	imageCapacityInput: u32,
	imageCountOutput: ^u32,
	images: ^SwapchainImageBaseHeader,
) -> Result

ProcAcquireSwapchainImage :: #type proc "system" (
	swapchain: Swapchain,
	acquireInfo: ^SwapchainImageAcquireInfo,
	index: ^u32,
) -> Result

ProcWaitSwapchainImage :: #type proc "system" (
	swapchain: Swapchain,
	waitInfo: ^SwapchainImageWaitInfo,
) -> Result

ProcReleaseSwapchainImage :: #type proc "system" (
	swapchain: Swapchain,
	releaseInfo: ^SwapchainImageReleaseInfo,
) -> Result

ProcBeginSession :: #type proc "system" (
	session: Session,
	beginInfo: ^SessionBeginInfo,
) -> Result

ProcEndSession :: #type proc "system" (
	session: Session,
) -> Result

ProcRequestExitSession :: #type proc "system" (
	session: Session,
) -> Result

ProcEnumerateReferenceSpaces :: #type proc "system" (
	session: Session,
	spaceCapacityInput: u32,
	spaceCountOutput: ^u32,
	spaces: ^ReferenceSpaceType,
) -> Result

ProcCreateReferenceSpace :: #type proc "system" (
	session: Session,
	createInfo: ^ReferenceSpaceCreateInfo,
	space: ^Space,
) -> Result

ProcCreateActionSpace :: #type proc "system" (
	session: Session,
	createInfo: ^ActionSpaceCreateInfo,
	space: ^Space,
) -> Result

ProcLocateSpace :: #type proc "system" (
	space: Space,
	baseSpace: Space,
	time: Time,
	location: ^SpaceLocation,
) -> Result

ProcEnumerateViewConfigurations :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationTypeCapacityInput: u32,
	viewConfigurationTypeCountOutput: ^u32,
	viewConfigurationTypes: ^ViewConfigurationType,
) -> Result

ProcEnumerateEnvironmentBlendModes :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
	environmentBlendModeCapacityInput: u32,
	environmentBlendModeCountOutput: ^u32,
	environmentBlendModes: ^EnvironmentBlendMode,
) -> Result

ProcGetViewConfigurationProperties :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
	configurationProperties: ^ViewConfigurationProperties,
) -> Result

ProcEnumerateViewConfigurationViews :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
	viewCapacityInput: u32,
	viewCountOutput: ^u32,
	views: ^ViewConfigurationView,
) -> Result

ProcBeginFrame :: #type proc "system" (
	session: Session,
	frameBeginInfo: ^FrameBeginInfo,
) -> Result

ProcLocateViews :: #type proc "system" (
	session: Session,
	viewLocateInfo: ^ViewLocateInfo,
	viewState: ^ViewState,
	viewCapacityInput: u32,
	viewCountOutput: ^u32,
	views: ^View,
) -> Result

ProcEndFrame :: #type proc "system" (
	session: Session,
	frameEndInfo: ^FrameEndInfo,
) -> Result

ProcWaitFrame :: #type proc "system" (
	session: Session,
	frameWaitInfo: ^FrameWaitInfo,
	frameState: ^FrameState,
) -> Result

ProcApplyHapticFeedback :: #type proc "system" (
	session: Session,
	hapticActionInfo: ^HapticActionInfo,
	hapticFeedback: ^HapticBaseHeader,
) -> Result

ProcStopHapticFeedback :: #type proc "system" (
	session: Session,
	hapticActionInfo: ^HapticActionInfo,
) -> Result

ProcPollEvent :: #type proc "system" (
	instance: Instance,
	eventData: ^EventDataBuffer,
) -> Result

ProcStringToPath :: #type proc "system" (
	instance: Instance,
	pathString: cstring,
	path: ^Path,
) -> Result

ProcPathToString :: #type proc "system" (
	instance: Instance,
	path: Path,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetReferenceSpaceBoundsRect :: #type proc "system" (
	session: Session,
	referenceSpaceType: ReferenceSpaceType,
	bounds: ^Extent2Df,
) -> Result

ProcSetAndroidApplicationThreadKHR :: #type proc "system" (
	session: Session,
	threadType: AndroidThreadTypeKHR,
	threadId: u32,
) -> Result

ProcCreateSwapchainAndroidSurfaceKHR :: #type proc "system" (
	session: Session,
	info: ^SwapchainCreateInfo,
	swapchain: ^Swapchain,
	surface: ^jobject,
) -> Result

ProcGetActionStateBoolean :: #type proc "system" (
	session: Session,
	getInfo: ^ActionStateGetInfo,
	state: ^ActionStateBoolean,
) -> Result

ProcGetActionStateFloat :: #type proc "system" (
	session: Session,
	getInfo: ^ActionStateGetInfo,
	state: ^ActionStateFloat,
) -> Result

ProcGetActionStateVector2f :: #type proc "system" (
	session: Session,
	getInfo: ^ActionStateGetInfo,
	state: ^ActionStateVector2f,
) -> Result

ProcGetActionStatePose :: #type proc "system" (
	session: Session,
	getInfo: ^ActionStateGetInfo,
	state: ^ActionStatePose,
) -> Result

ProcCreateActionSet :: #type proc "system" (
	instance: Instance,
	createInfo: ^ActionSetCreateInfo,
	actionSet: ^ActionSet,
) -> Result

ProcDestroyActionSet :: #type proc "system" (
	actionSet: ActionSet,
) -> Result

ProcCreateAction :: #type proc "system" (
	actionSet: ActionSet,
	createInfo: ^ActionCreateInfo,
	action: ^Action,
) -> Result

ProcDestroyAction :: #type proc "system" (
	action: Action,
) -> Result

ProcSuggestInteractionProfileBindings :: #type proc "system" (
	instance: Instance,
	suggestedBindings: ^InteractionProfileSuggestedBinding,
) -> Result

ProcAttachSessionActionSets :: #type proc "system" (
	session: Session,
	attachInfo: ^SessionActionSetsAttachInfo,
) -> Result

ProcGetCurrentInteractionProfile :: #type proc "system" (
	session: Session,
	topLevelUserPath: Path,
	interactionProfile: ^InteractionProfileState,
) -> Result

ProcSyncActions :: #type proc "system" (
	session: Session,
	syncInfo: ^ActionsSyncInfo,
) -> Result

ProcEnumerateBoundSourcesForAction :: #type proc "system" (
	session: Session,
	enumerateInfo: ^BoundSourcesForActionEnumerateInfo,
	sourceCapacityInput: u32,
	sourceCountOutput: ^u32,
	sources: ^Path,
) -> Result

ProcGetInputSourceLocalizedName :: #type proc "system" (
	session: Session,
	getInfo: ^InputSourceLocalizedNameGetInfo,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetVulkanInstanceExtensionsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetVulkanDeviceExtensionsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: cstring,
) -> Result

ProcGetVulkanGraphicsDeviceKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	vkInstance: vk.Instance,
	vkPhysicalDevice: ^vk.PhysicalDevice,
) -> Result

ProcGetOpenGLGraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsOpenGLKHR,
) -> Result

ProcGetOpenGLESGraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsOpenGLESKHR,
) -> Result

ProcGetVulkanGraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsVulkanKHR,
) -> Result

ProcGetD3D11GraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsD3D11KHR,
) -> Result

ProcGetD3D12GraphicsRequirementsKHR :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	graphicsRequirements: ^GraphicsRequirementsD3D12KHR,
) -> Result

ProcPerfSettingsSetPerformanceLevelEXT :: #type proc "system" (
	session: Session,
	domain: PerfSettingsDomainEXT,
	level: PerfSettingsLevelEXT,
) -> Result

ProcThermalGetTemperatureTrendEXT :: #type proc "system" (
	session: Session,
	domain: PerfSettingsDomainEXT,
	notificationLevel: ^PerfSettingsNotificationLevelEXT,
	tempHeadroom: ^f32,
	tempSlope: ^f32,
) -> Result

ProcSetDebugUtilsObjectNameEXT :: #type proc "system" (
	instance: Instance,
	nameInfo: ^DebugUtilsObjectNameInfoEXT,
) -> Result

ProcCreateDebugUtilsMessengerEXT :: #type proc "system" (
	instance: Instance,
	createInfo: ^DebugUtilsMessengerCreateInfoEXT,
	messenger: ^DebugUtilsMessengerEXT,
) -> Result

ProcDestroyDebugUtilsMessengerEXT :: #type proc "system" (
	messenger: DebugUtilsMessengerEXT,
) -> Result

ProcSubmitDebugUtilsMessageEXT :: #type proc "system" (
	instance: Instance,
	messageSeverity: DebugUtilsMessageSeverityFlagsEXT,
	messageTypes: DebugUtilsMessageTypeFlagsEXT,
	callbackData: ^DebugUtilsMessengerCallbackDataEXT,
) -> Result

ProcSessionBeginDebugUtilsLabelRegionEXT :: #type proc "system" (
	session: Session,
	labelInfo: ^DebugUtilsLabelEXT,
) -> Result

ProcSessionEndDebugUtilsLabelRegionEXT :: #type proc "system" (
	session: Session,
) -> Result

ProcSessionInsertDebugUtilsLabelEXT :: #type proc "system" (
	session: Session,
	labelInfo: ^DebugUtilsLabelEXT,
) -> Result

ProcConvertTimeToWin32PerformanceCounterKHR :: #type proc "system" (
	instance: Instance,
	time: Time,
	performanceCounter: ^LARGE_INTEGER,
) -> Result

ProcConvertWin32PerformanceCounterToTimeKHR :: #type proc "system" (
	instance: Instance,
	performanceCounter: ^LARGE_INTEGER,
	time: ^Time,
) -> Result

ProcCreateVulkanInstanceKHR :: #type proc "system" (
	instance: Instance,
	createInfo: ^VulkanInstanceCreateInfoKHR,
	vulkanInstance: ^vk.Instance,
	vulkanResult: ^vk.Result,
) -> Result

ProcCreateVulkanDeviceKHR :: #type proc "system" (
	instance: Instance,
	createInfo: ^VulkanDeviceCreateInfoKHR,
	vulkanDevice: ^vk.Device,
	vulkanResult: ^vk.Result,
) -> Result

ProcGetVulkanGraphicsDevice2KHR :: #type proc "system" (
	instance: Instance,
	getInfo: ^VulkanGraphicsDeviceGetInfoKHR,
	vulkanPhysicalDevice: ^vk.PhysicalDevice,
) -> Result

ProcConvertTimeToTimespecTimeKHR :: #type proc "system" (
	instance: Instance,
	time: Time,
	timespecTime: ^timespec,
) -> Result

ProcConvertTimespecTimeToTimeKHR :: #type proc "system" (
	instance: Instance,
	timespecTime: ^timespec,
	time: ^Time,
) -> Result

ProcGetVisibilityMaskKHR :: #type proc "system" (
	session: Session,
	viewConfigurationType: ViewConfigurationType,
	viewIndex: u32,
	visibilityMaskType: VisibilityMaskTypeKHR,
	visibilityMask: ^VisibilityMaskKHR,
) -> Result

ProcCreateSpatialAnchorMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialAnchorCreateInfoMSFT,
	anchor: ^SpatialAnchorMSFT,
) -> Result

ProcCreateSpatialAnchorSpaceMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialAnchorSpaceCreateInfoMSFT,
	space: ^Space,
) -> Result

ProcDestroySpatialAnchorMSFT :: #type proc "system" (
	anchor: SpatialAnchorMSFT,
) -> Result

ProcSetInputDeviceActiveEXT :: #type proc "system" (
	session: Session,
	interactionProfile: Path,
	topLevelPath: Path,
	isActive: b32,
) -> Result

ProcSetInputDeviceStateBoolEXT :: #type proc "system" (
	session: Session,
	topLevelPath: Path,
	inputSourcePath: Path,
	state: b32,
) -> Result

ProcSetInputDeviceStateFloatEXT :: #type proc "system" (
	session: Session,
	topLevelPath: Path,
	inputSourcePath: Path,
	state: f32,
) -> Result

ProcSetInputDeviceStateVector2fEXT :: #type proc "system" (
	session: Session,
	topLevelPath: Path,
	inputSourcePath: Path,
	state: Vector2f,
) -> Result

ProcSetInputDeviceLocationEXT :: #type proc "system" (
	session: Session,
	topLevelPath: Path,
	inputSourcePath: Path,
	space: Space,
	pose: Posef,
) -> Result

ProcInitializeLoaderKHR :: #type proc "system" (
	loaderInitInfo: ^LoaderInitInfoBaseHeaderKHR,
) -> Result

ProcCreateSpatialGraphNodeSpaceMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialGraphNodeSpaceCreateInfoMSFT,
	space: ^Space,
) -> Result

ProcTryCreateSpatialGraphStaticNodeBindingMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SpatialGraphStaticNodeBindingCreateInfoMSFT,
	nodeBinding: ^SpatialGraphNodeBindingMSFT,
) -> Result

ProcDestroySpatialGraphNodeBindingMSFT :: #type proc "system" (
	nodeBinding: SpatialGraphNodeBindingMSFT,
) -> Result

ProcGetSpatialGraphNodeBindingPropertiesMSFT :: #type proc "system" (
	nodeBinding: SpatialGraphNodeBindingMSFT,
	getInfo: ^SpatialGraphNodeBindingPropertiesGetInfoMSFT,
	properties: ^SpatialGraphNodeBindingPropertiesMSFT,
) -> Result

ProcCreateHandTrackerEXT :: #type proc "system" (
	session: Session,
	createInfo: ^HandTrackerCreateInfoEXT,
	handTracker: ^HandTrackerEXT,
) -> Result

ProcDestroyHandTrackerEXT :: #type proc "system" (
	handTracker: HandTrackerEXT,
) -> Result

ProcLocateHandJointsEXT :: #type proc "system" (
	handTracker: HandTrackerEXT,
	locateInfo: ^HandJointsLocateInfoEXT,
	locations: ^HandJointLocationsEXT,
) -> Result

ProcCreateHandMeshSpaceMSFT :: #type proc "system" (
	handTracker: HandTrackerEXT,
	createInfo: ^HandMeshSpaceCreateInfoMSFT,
	space: ^Space,
) -> Result

ProcUpdateHandMeshMSFT :: #type proc "system" (
	handTracker: HandTrackerEXT,
	updateInfo: ^HandMeshUpdateInfoMSFT,
	handMesh: ^HandMeshMSFT,
) -> Result

ProcGetControllerModelKeyMSFT :: #type proc "system" (
	session: Session,
	topLevelUserPath: Path,
	controllerModelKeyState: ^ControllerModelKeyStateMSFT,
) -> Result

ProcLoadControllerModelMSFT :: #type proc "system" (
	session: Session,
	modelKey: ControllerModelKeyMSFT,
	bufferCapacityInput: u32,
	bufferCountOutput: ^u32,
	buffer: ^u8,
) -> Result

ProcGetControllerModelPropertiesMSFT :: #type proc "system" (
	session: Session,
	modelKey: ControllerModelKeyMSFT,
	properties: ^ControllerModelPropertiesMSFT,
) -> Result

ProcGetControllerModelStateMSFT :: #type proc "system" (
	session: Session,
	modelKey: ControllerModelKeyMSFT,
	state: ^ControllerModelStateMSFT,
) -> Result

ProcEnumerateSceneComputeFeaturesMSFT :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	featureCapacityInput: u32,
	featureCountOutput: ^u32,
	features: ^SceneComputeFeatureMSFT,
) -> Result

ProcCreateSceneObserverMSFT :: #type proc "system" (
	session: Session,
	createInfo: ^SceneObserverCreateInfoMSFT,
	sceneObserver: ^SceneObserverMSFT,
) -> Result

ProcDestroySceneObserverMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
) -> Result

ProcCreateSceneMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
	createInfo: ^SceneCreateInfoMSFT,
	scene: ^SceneMSFT,
) -> Result

ProcDestroySceneMSFT :: #type proc "system" (
	scene: SceneMSFT,
) -> Result

ProcComputeNewSceneMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
	computeInfo: ^NewSceneComputeInfoMSFT,
) -> Result

ProcGetSceneComputeStateMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
	state: ^SceneComputeStateMSFT,
) -> Result

ProcGetSceneComponentsMSFT :: #type proc "system" (
	scene: SceneMSFT,
	getInfo: ^SceneComponentsGetInfoMSFT,
	components: ^SceneComponentsMSFT,
) -> Result

ProcLocateSceneComponentsMSFT :: #type proc "system" (
	scene: SceneMSFT,
	locateInfo: ^SceneComponentsLocateInfoMSFT,
	locations: ^SceneComponentLocationsMSFT,
) -> Result

ProcGetSceneMeshBuffersMSFT :: #type proc "system" (
	scene: SceneMSFT,
	getInfo: ^SceneMeshBuffersGetInfoMSFT,
	buffers: ^SceneMeshBuffersMSFT,
) -> Result

ProcDeserializeSceneMSFT :: #type proc "system" (
	sceneObserver: SceneObserverMSFT,
	deserializeInfo: ^SceneDeserializeInfoMSFT,
) -> Result

ProcGetSerializedSceneFragmentDataMSFT :: #type proc "system" (
	scene: SceneMSFT,
	getInfo: ^SerializedSceneFragmentDataGetInfoMSFT,
	countInput: u32,
	readOutput: ^u32,
	buffer: ^u8,
) -> Result

ProcEnumerateDisplayRefreshRatesFB :: #type proc "system" (
	session: Session,
	displayRefreshRateCapacityInput: u32,
	displayRefreshRateCountOutput: ^u32,
	displayRefreshRates: ^f32,
) -> Result

ProcGetDisplayRefreshRateFB :: #type proc "system" (
	session: Session,
	displayRefreshRate: ^f32,
) -> Result

ProcRequestDisplayRefreshRateFB :: #type proc "system" (
	session: Session,
	displayRefreshRate: f32,
) -> Result

ProcCreateSpatialAnchorFromPerceptionAnchorMSFT :: #type proc "system" (
	session: Session,
	perceptionAnchor: ^IUnknown,
	anchor: ^SpatialAnchorMSFT,
) -> Result

ProcTryGetPerceptionAnchorFromSpatialAnchorMSFT :: #type proc "system" (
	session: Session,
	anchor: SpatialAnchorMSFT,
	perceptionAnchor: ^^IUnknown,
) -> Result

ProcUpdateSwapchainFB :: #type proc "system" (
	swapchain: Swapchain,
	state: ^SwapchainStateBaseHeaderFB,
) -> Result

ProcGetSwapchainStateFB :: #type proc "system" (
	swapchain: Swapchain,
	state: ^SwapchainStateBaseHeaderFB,
) -> Result

ProcEnumerateColorSpacesFB :: #type proc "system" (
	session: Session,
	colorSpaceCapacityInput: u32,
	colorSpaceCountOutput: ^u32,
	colorSpaces: ^ColorSpaceFB,
) -> Result

ProcSetColorSpaceFB :: #type proc "system" (
	session: Session,
	colorspace: ColorSpaceFB,
) -> Result

ProcCreateFoveationProfileFB :: #type proc "system" (
	session: Session,
	createInfo: ^FoveationProfileCreateInfoFB,
	profile: ^FoveationProfileFB,
) -> Result

ProcDestroyFoveationProfileFB :: #type proc "system" (
	profile: FoveationProfileFB,
) -> Result

ProcGetHandMeshFB :: #type proc "system" (
	handTracker: HandTrackerEXT,
	mesh: ^HandTrackingMeshFB,
) -> Result

ProcEnumerateRenderModelPathsFB :: #type proc "system" (
	session: Session,
	pathCapacityInput: u32,
	pathCountOutput: ^u32,
	paths: ^RenderModelPathInfoFB,
) -> Result

ProcGetRenderModelPropertiesFB :: #type proc "system" (
	session: Session,
	path: Path,
	properties: ^RenderModelPropertiesFB,
) -> Result

ProcLoadRenderModelFB :: #type proc "system" (
	session: Session,
	info: ^RenderModelLoadInfoFB,
	buffer: ^RenderModelBufferFB,
) -> Result

ProcQuerySystemTrackedKeyboardFB :: #type proc "system" (
	session: Session,
	queryInfo: ^KeyboardTrackingQueryFB,
	keyboard: ^KeyboardTrackingDescriptionFB,
) -> Result

ProcCreateKeyboardSpaceFB :: #type proc "system" (
	session: Session,
	createInfo: ^KeyboardSpaceCreateInfoFB,
	keyboardSpace: ^Space,
) -> Result

ProcSetEnvironmentDepthEstimationVARJO :: #type proc "system" (
	session: Session,
	enabled: b32,
) -> Result

ProcEnumerateReprojectionModesMSFT :: #type proc "system" (
	instance: Instance,
	systemId: SystemId,
	viewConfigurationType: ViewConfigurationType,
	modeCapacityInput: u32,
	modeCountOutput: ^u32,
	modes: ^ReprojectionModeMSFT,
) -> Result

ProcGetAudioOutputDeviceGuidOculus :: #type proc "system" (
	instance: Instance,
	buffer: [^]wchar_t,
) -> Result

ProcGetAudioInputDeviceGuidOculus :: #type proc "system" (
	instance: Instance,
	buffer: [^]wchar_t,
) -> Result

ProcCreateSpatialAnchorFB :: #type proc "system" (
	session: Session,
	info: ^SpatialAnchorCreateInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcGetSpaceUuidFB :: #type proc "system" (
	space: Space,
	uuid: ^UuidEXT,
) -> Result

ProcEnumerateSpaceSupportedComponentsFB :: #type proc "system" (
	space: Space,
	componentTypeCapacityInput: u32,
	componentTypeCountOutput: ^u32,
	componentTypes: ^SpaceComponentTypeFB,
) -> Result

ProcSetSpaceComponentStatusFB :: #type proc "system" (
	space: Space,
	info: ^SpaceComponentStatusSetInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcGetSpaceComponentStatusFB :: #type proc "system" (
	space: Space,
	componentType: SpaceComponentTypeFB,
	status: ^SpaceComponentStatusFB,
) -> Result

ProcCreateTriangleMeshFB :: #type proc "system" (
	session: Session,
	createInfo: ^TriangleMeshCreateInfoFB,
	outTriangleMesh: ^TriangleMeshFB,
) -> Result

ProcDestroyTriangleMeshFB :: #type proc "system" (
	mesh: TriangleMeshFB,
) -> Result

ProcTriangleMeshGetVertexBufferFB :: #type proc "system" (
	mesh: TriangleMeshFB,
	outVertexBuffer: ^^Vector3f,
) -> Result

ProcTriangleMeshGetIndexBufferFB :: #type proc "system" (
	mesh: TriangleMeshFB,
	outIndexBuffer: ^^u32,
) -> Result

ProcTriangleMeshBeginUpdateFB :: #type proc "system" (
	mesh: TriangleMeshFB,
) -> Result

ProcTriangleMeshEndUpdateFB :: #type proc "system" (
	mesh: TriangleMeshFB,
	vertexCount: u32,
	triangleCount: u32,
) -> Result

ProcTriangleMeshBeginVertexBufferUpdateFB :: #type proc "system" (
	mesh: TriangleMeshFB,
	outVertexCount: ^u32,
) -> Result

ProcTriangleMeshEndVertexBufferUpdateFB :: #type proc "system" (
	mesh: TriangleMeshFB,
) -> Result

ProcCreatePassthroughFB :: #type proc "system" (
	session: Session,
	createInfo: ^PassthroughCreateInfoFB,
	outPassthrough: ^PassthroughFB,
) -> Result

ProcDestroyPassthroughFB :: #type proc "system" (
	passthrough: PassthroughFB,
) -> Result

ProcPassthroughStartFB :: #type proc "system" (
	passthrough: PassthroughFB,
) -> Result

ProcPassthroughPauseFB :: #type proc "system" (
	passthrough: PassthroughFB,
) -> Result

ProcCreatePassthroughLayerFB :: #type proc "system" (
	session: Session,
	createInfo: ^PassthroughLayerCreateInfoFB,
	outLayer: ^PassthroughLayerFB,
) -> Result

ProcDestroyPassthroughLayerFB :: #type proc "system" (
	layer: PassthroughLayerFB,
) -> Result

ProcPassthroughLayerPauseFB :: #type proc "system" (
	layer: PassthroughLayerFB,
) -> Result

ProcPassthroughLayerResumeFB :: #type proc "system" (
	layer: PassthroughLayerFB,
) -> Result

ProcPassthroughLayerSetStyleFB :: #type proc "system" (
	layer: PassthroughLayerFB,
	style: ^PassthroughStyleFB,
) -> Result

ProcCreateGeometryInstanceFB :: #type proc "system" (
	session: Session,
	createInfo: ^GeometryInstanceCreateInfoFB,
	outGeometryInstance: ^GeometryInstanceFB,
) -> Result

ProcDestroyGeometryInstanceFB :: #type proc "system" (
	instance: GeometryInstanceFB,
) -> Result

ProcGeometryInstanceSetTransformFB :: #type proc "system" (
	instance: GeometryInstanceFB,
	transformation: ^GeometryInstanceTransformFB,
) -> Result

ProcQuerySpacesFB :: #type proc "system" (
	session: Session,
	info: ^SpaceQueryInfoBaseHeaderFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcRetrieveSpaceQueryResultsFB :: #type proc "system" (
	session: Session,
	requestId: AsyncRequestIdFB,
	results: ^SpaceQueryResultsFB,
) -> Result

ProcSaveSpaceFB :: #type proc "system" (
	session: Session,
	info: ^SpaceSaveInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcEraseSpaceFB :: #type proc "system" (
	session: Session,
	info: ^SpaceEraseInfoFB,
	requestId: ^AsyncRequestIdFB,
) -> Result

ProcGetSpaceContainerFB :: #type proc "system" (
	session: Session,
	space: Space,
	spaceContainerOutput: ^SpaceContainerFB,
) -> Result

ProcGetSpaceBoundingBox2DFB :: #type proc "system" (
	session: Session,
	space: Space,
	boundingBox2DOutput: ^Rect2Df,
) -> Result

ProcGetSpaceBoundingBox3DFB :: #type proc "system" (
	session: Session,
	space: Space,
	boundingBox3DOutput: ^Rect3DfFB,
) -> Result

ProcGetSpaceSemanticLabelsFB :: #type proc "system" (
	session: Session,
	space: Space,
	semanticLabelsOutput: ^SemanticLabelsFB,
) -> Result

ProcGetSpaceBoundary2DFB :: #type proc "system" (
	session: Session,
	space: Space,
	boundary2DOutput: ^Boundary2DFB,
) -> Result

ProcGetSpaceRoomLayoutFB :: #type proc "system" (
	session: Session,
	space: Space,
	roomLayoutOutput: ^RoomLayoutFB,
) -> Result

ProcPassthroughLayerSetKeyboardHandsIntensityFB :: #type proc "system" (
	layer: PassthroughLayerFB,
	intensity: ^PassthroughKeyboardHandsIntensityFB,
) -> Result

ProcCreateSpatialAnchorStoreConnectionMSFT :: #type proc "system" (
	session: Session,
	spatialAnchorStore: ^SpatialAnchorStoreConnectionMSFT,
) -> Result

ProcDestroySpatialAnchorStoreConnectionMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
) -> Result

ProcPersistSpatialAnchorMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
	spatialAnchorPersistenceInfo: ^SpatialAnchorPersistenceInfoMSFT,
) -> Result

ProcEnumeratePersistedSpatialAnchorNamesMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
	spatialAnchorNamesCapacityInput: u32,
	spatialAnchorNamesCountOutput: ^u32,
	persistedAnchorNames: ^SpatialAnchorPersistenceNameMSFT,
) -> Result

ProcCreateSpatialAnchorFromPersistedNameMSFT :: #type proc "system" (
	session: Session,
	spatialAnchorCreateInfo: ^SpatialAnchorFromPersistedAnchorCreateInfoMSFT,
	spatialAnchor: ^SpatialAnchorMSFT,
) -> Result

ProcUnpersistSpatialAnchorMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
	spatialAnchorPersistenceName: ^SpatialAnchorPersistenceNameMSFT,
) -> Result

ProcClearSpatialAnchorStoreMSFT :: #type proc "system" (
	spatialAnchorStore: SpatialAnchorStoreConnectionMSFT,
) -> Result

ProcCreateFacialTrackerHTC :: #type proc "system" (
	session: Session,
	createInfo: ^FacialTrackerCreateInfoHTC,
	facialTracker: ^FacialTrackerHTC,
) -> Result

ProcDestroyFacialTrackerHTC :: #type proc "system" (
	facialTracker: FacialTrackerHTC,
) -> Result

ProcGetFacialExpressionsHTC :: #type proc "system" (
	facialTracker: FacialTrackerHTC,
	facialExpressions: ^FacialExpressionsHTC,
) -> Result

ProcCreatePassthroughHTC :: #type proc "system" (
	session: Session,
	createInfo: ^PassthroughCreateInfoHTC,
	passthrough: ^PassthroughHTC,
) -> Result

ProcDestroyPassthroughHTC :: #type proc "system" (
	passthrough: PassthroughHTC,
) -> Result

ProcEnumerateViveTrackerPathsHTCX :: #type proc "system" (
	instance: Instance,
	pathCapacityInput: u32,
	pathCountOutput: ^u32,
	paths: ^ViveTrackerPathsHTCX,
) -> Result

ProcSetMarkerTrackingVARJO :: #type proc "system" (
	session: Session,
	enabled: b32,
) -> Result

ProcSetMarkerTrackingTimeoutVARJO :: #type proc "system" (
	session: Session,
	markerId: u64,
	timeout: Duration,
) -> Result

ProcSetMarkerTrackingPredictionVARJO :: #type proc "system" (
	session: Session,
	markerId: u64,
	enabled: b32,
) -> Result

ProcGetMarkerSizeVARJO :: #type proc "system" (
	session: Session,
	markerId: u64,
	size: ^Extent2Df,
) -> Result

ProcCreateMarkerSpaceVARJO :: #type proc "system" (
	session: Session,
	createInfo: ^MarkerSpaceCreateInfoVARJO,
	space: ^Space,
) -> Result

ProcSetDigitalLensControlALMALENCE :: #type proc "system" (
	session: Session,
	digitalLensControl: ^DigitalLensControlALMALENCE,
) -> Result

ProcSetViewOffsetVARJO :: #type proc "system" (
	session: Session,
	offset: f32,
) -> Result

ProcEnumeratePerformanceMetricsCounterPathsMETA :: #type proc "system" (
	instance: Instance,
	counterPathCapacityInput: u32,
	counterPathCountOutput: ^u32,
	counterPaths: ^Path,
) -> Result

ProcSetPerformanceMetricsStateMETA :: #type proc "system" (
	session: Session,
	state: ^PerformanceMetricsStateMETA,
) -> Result

ProcGetPerformanceMetricsStateMETA :: #type proc "system" (
	session: Session,
	state: ^PerformanceMetricsStateMETA,
) -> Result

ProcQueryPerformanceMetricsCounterMETA :: #type proc "system" (
	session: Session,
	counterPath: Path,
	counter: ^PerformanceMetricsCounterMETA,
) -> Result

ProcApplyFoveationHTC :: #type proc "system" (
	session: Session,
	applyInfo: ^FoveationApplyInfoHTC,
) -> Result



EnumerateApiLayerProperties: ProcEnumerateApiLayerProperties
EnumerateInstanceExtensionProperties: ProcEnumerateInstanceExtensionProperties
CreateInstance: ProcCreateInstance
DestroyInstance: ProcDestroyInstance
ResultToString: ProcResultToString
StructureTypeToString: ProcStructureTypeToString
GetInstanceProperties: ProcGetInstanceProperties
GetSystem: ProcGetSystem
GetSystemProperties: ProcGetSystemProperties
CreateSession: ProcCreateSession
DestroySession: ProcDestroySession
DestroySpace: ProcDestroySpace
EnumerateSwapchainFormats: ProcEnumerateSwapchainFormats
CreateSwapchain: ProcCreateSwapchain
DestroySwapchain: ProcDestroySwapchain
EnumerateSwapchainImages: ProcEnumerateSwapchainImages
AcquireSwapchainImage: ProcAcquireSwapchainImage
WaitSwapchainImage: ProcWaitSwapchainImage
ReleaseSwapchainImage: ProcReleaseSwapchainImage
BeginSession: ProcBeginSession
EndSession: ProcEndSession
RequestExitSession: ProcRequestExitSession
EnumerateReferenceSpaces: ProcEnumerateReferenceSpaces
CreateReferenceSpace: ProcCreateReferenceSpace
CreateActionSpace: ProcCreateActionSpace
LocateSpace: ProcLocateSpace
EnumerateViewConfigurations: ProcEnumerateViewConfigurations
EnumerateEnvironmentBlendModes: ProcEnumerateEnvironmentBlendModes
GetViewConfigurationProperties: ProcGetViewConfigurationProperties
EnumerateViewConfigurationViews: ProcEnumerateViewConfigurationViews
BeginFrame: ProcBeginFrame
LocateViews: ProcLocateViews
EndFrame: ProcEndFrame
WaitFrame: ProcWaitFrame
ApplyHapticFeedback: ProcApplyHapticFeedback
StopHapticFeedback: ProcStopHapticFeedback
PollEvent: ProcPollEvent
StringToPath: ProcStringToPath
PathToString: ProcPathToString
GetReferenceSpaceBoundsRect: ProcGetReferenceSpaceBoundsRect
SetAndroidApplicationThreadKHR: ProcSetAndroidApplicationThreadKHR
CreateSwapchainAndroidSurfaceKHR: ProcCreateSwapchainAndroidSurfaceKHR
GetActionStateBoolean: ProcGetActionStateBoolean
GetActionStateFloat: ProcGetActionStateFloat
GetActionStateVector2f: ProcGetActionStateVector2f
GetActionStatePose: ProcGetActionStatePose
CreateActionSet: ProcCreateActionSet
DestroyActionSet: ProcDestroyActionSet
CreateAction: ProcCreateAction
DestroyAction: ProcDestroyAction
SuggestInteractionProfileBindings: ProcSuggestInteractionProfileBindings
AttachSessionActionSets: ProcAttachSessionActionSets
GetCurrentInteractionProfile: ProcGetCurrentInteractionProfile
SyncActions: ProcSyncActions
EnumerateBoundSourcesForAction: ProcEnumerateBoundSourcesForAction
GetInputSourceLocalizedName: ProcGetInputSourceLocalizedName
GetVulkanInstanceExtensionsKHR: ProcGetVulkanInstanceExtensionsKHR
GetVulkanDeviceExtensionsKHR: ProcGetVulkanDeviceExtensionsKHR
GetVulkanGraphicsDeviceKHR: ProcGetVulkanGraphicsDeviceKHR
GetOpenGLGraphicsRequirementsKHR: ProcGetOpenGLGraphicsRequirementsKHR
GetOpenGLESGraphicsRequirementsKHR: ProcGetOpenGLESGraphicsRequirementsKHR
GetVulkanGraphicsRequirementsKHR: ProcGetVulkanGraphicsRequirementsKHR
GetD3D11GraphicsRequirementsKHR: ProcGetD3D11GraphicsRequirementsKHR
GetD3D12GraphicsRequirementsKHR: ProcGetD3D12GraphicsRequirementsKHR
PerfSettingsSetPerformanceLevelEXT: ProcPerfSettingsSetPerformanceLevelEXT
ThermalGetTemperatureTrendEXT: ProcThermalGetTemperatureTrendEXT
SetDebugUtilsObjectNameEXT: ProcSetDebugUtilsObjectNameEXT
CreateDebugUtilsMessengerEXT: ProcCreateDebugUtilsMessengerEXT
DestroyDebugUtilsMessengerEXT: ProcDestroyDebugUtilsMessengerEXT
SubmitDebugUtilsMessageEXT: ProcSubmitDebugUtilsMessageEXT
SessionBeginDebugUtilsLabelRegionEXT: ProcSessionBeginDebugUtilsLabelRegionEXT
SessionEndDebugUtilsLabelRegionEXT: ProcSessionEndDebugUtilsLabelRegionEXT
SessionInsertDebugUtilsLabelEXT: ProcSessionInsertDebugUtilsLabelEXT
ConvertTimeToWin32PerformanceCounterKHR: ProcConvertTimeToWin32PerformanceCounterKHR
ConvertWin32PerformanceCounterToTimeKHR: ProcConvertWin32PerformanceCounterToTimeKHR
CreateVulkanInstanceKHR: ProcCreateVulkanInstanceKHR
CreateVulkanDeviceKHR: ProcCreateVulkanDeviceKHR
GetVulkanGraphicsDevice2KHR: ProcGetVulkanGraphicsDevice2KHR
GetVulkanGraphicsRequirements2KHR: ProcGetVulkanGraphicsRequirementsKHR
ConvertTimeToTimespecTimeKHR: ProcConvertTimeToTimespecTimeKHR
ConvertTimespecTimeToTimeKHR: ProcConvertTimespecTimeToTimeKHR
GetVisibilityMaskKHR: ProcGetVisibilityMaskKHR
CreateSpatialAnchorMSFT: ProcCreateSpatialAnchorMSFT
CreateSpatialAnchorSpaceMSFT: ProcCreateSpatialAnchorSpaceMSFT
DestroySpatialAnchorMSFT: ProcDestroySpatialAnchorMSFT
SetInputDeviceActiveEXT: ProcSetInputDeviceActiveEXT
SetInputDeviceStateBoolEXT: ProcSetInputDeviceStateBoolEXT
SetInputDeviceStateFloatEXT: ProcSetInputDeviceStateFloatEXT
SetInputDeviceStateVector2fEXT: ProcSetInputDeviceStateVector2fEXT
SetInputDeviceLocationEXT: ProcSetInputDeviceLocationEXT
InitializeLoaderKHR: ProcInitializeLoaderKHR
CreateSpatialGraphNodeSpaceMSFT: ProcCreateSpatialGraphNodeSpaceMSFT
TryCreateSpatialGraphStaticNodeBindingMSFT: ProcTryCreateSpatialGraphStaticNodeBindingMSFT
DestroySpatialGraphNodeBindingMSFT: ProcDestroySpatialGraphNodeBindingMSFT
GetSpatialGraphNodeBindingPropertiesMSFT: ProcGetSpatialGraphNodeBindingPropertiesMSFT
CreateHandTrackerEXT: ProcCreateHandTrackerEXT
DestroyHandTrackerEXT: ProcDestroyHandTrackerEXT
LocateHandJointsEXT: ProcLocateHandJointsEXT
CreateHandMeshSpaceMSFT: ProcCreateHandMeshSpaceMSFT
UpdateHandMeshMSFT: ProcUpdateHandMeshMSFT
GetControllerModelKeyMSFT: ProcGetControllerModelKeyMSFT
LoadControllerModelMSFT: ProcLoadControllerModelMSFT
GetControllerModelPropertiesMSFT: ProcGetControllerModelPropertiesMSFT
GetControllerModelStateMSFT: ProcGetControllerModelStateMSFT
EnumerateSceneComputeFeaturesMSFT: ProcEnumerateSceneComputeFeaturesMSFT
CreateSceneObserverMSFT: ProcCreateSceneObserverMSFT
DestroySceneObserverMSFT: ProcDestroySceneObserverMSFT
CreateSceneMSFT: ProcCreateSceneMSFT
DestroySceneMSFT: ProcDestroySceneMSFT
ComputeNewSceneMSFT: ProcComputeNewSceneMSFT
GetSceneComputeStateMSFT: ProcGetSceneComputeStateMSFT
GetSceneComponentsMSFT: ProcGetSceneComponentsMSFT
LocateSceneComponentsMSFT: ProcLocateSceneComponentsMSFT
GetSceneMeshBuffersMSFT: ProcGetSceneMeshBuffersMSFT
DeserializeSceneMSFT: ProcDeserializeSceneMSFT
GetSerializedSceneFragmentDataMSFT: ProcGetSerializedSceneFragmentDataMSFT
EnumerateDisplayRefreshRatesFB: ProcEnumerateDisplayRefreshRatesFB
GetDisplayRefreshRateFB: ProcGetDisplayRefreshRateFB
RequestDisplayRefreshRateFB: ProcRequestDisplayRefreshRateFB
CreateSpatialAnchorFromPerceptionAnchorMSFT: ProcCreateSpatialAnchorFromPerceptionAnchorMSFT
TryGetPerceptionAnchorFromSpatialAnchorMSFT: ProcTryGetPerceptionAnchorFromSpatialAnchorMSFT
UpdateSwapchainFB: ProcUpdateSwapchainFB
GetSwapchainStateFB: ProcGetSwapchainStateFB
EnumerateColorSpacesFB: ProcEnumerateColorSpacesFB
SetColorSpaceFB: ProcSetColorSpaceFB
CreateFoveationProfileFB: ProcCreateFoveationProfileFB
DestroyFoveationProfileFB: ProcDestroyFoveationProfileFB
GetHandMeshFB: ProcGetHandMeshFB
EnumerateRenderModelPathsFB: ProcEnumerateRenderModelPathsFB
GetRenderModelPropertiesFB: ProcGetRenderModelPropertiesFB
LoadRenderModelFB: ProcLoadRenderModelFB
QuerySystemTrackedKeyboardFB: ProcQuerySystemTrackedKeyboardFB
CreateKeyboardSpaceFB: ProcCreateKeyboardSpaceFB
SetEnvironmentDepthEstimationVARJO: ProcSetEnvironmentDepthEstimationVARJO
EnumerateReprojectionModesMSFT: ProcEnumerateReprojectionModesMSFT
GetAudioOutputDeviceGuidOculus: ProcGetAudioOutputDeviceGuidOculus
GetAudioInputDeviceGuidOculus: ProcGetAudioInputDeviceGuidOculus
CreateSpatialAnchorFB: ProcCreateSpatialAnchorFB
GetSpaceUuidFB: ProcGetSpaceUuidFB
EnumerateSpaceSupportedComponentsFB: ProcEnumerateSpaceSupportedComponentsFB
SetSpaceComponentStatusFB: ProcSetSpaceComponentStatusFB
GetSpaceComponentStatusFB: ProcGetSpaceComponentStatusFB
CreateTriangleMeshFB: ProcCreateTriangleMeshFB
DestroyTriangleMeshFB: ProcDestroyTriangleMeshFB
TriangleMeshGetVertexBufferFB: ProcTriangleMeshGetVertexBufferFB
TriangleMeshGetIndexBufferFB: ProcTriangleMeshGetIndexBufferFB
TriangleMeshBeginUpdateFB: ProcTriangleMeshBeginUpdateFB
TriangleMeshEndUpdateFB: ProcTriangleMeshEndUpdateFB
TriangleMeshBeginVertexBufferUpdateFB: ProcTriangleMeshBeginVertexBufferUpdateFB
TriangleMeshEndVertexBufferUpdateFB: ProcTriangleMeshEndVertexBufferUpdateFB
CreatePassthroughFB: ProcCreatePassthroughFB
DestroyPassthroughFB: ProcDestroyPassthroughFB
PassthroughStartFB: ProcPassthroughStartFB
PassthroughPauseFB: ProcPassthroughPauseFB
CreatePassthroughLayerFB: ProcCreatePassthroughLayerFB
DestroyPassthroughLayerFB: ProcDestroyPassthroughLayerFB
PassthroughLayerPauseFB: ProcPassthroughLayerPauseFB
PassthroughLayerResumeFB: ProcPassthroughLayerResumeFB
PassthroughLayerSetStyleFB: ProcPassthroughLayerSetStyleFB
CreateGeometryInstanceFB: ProcCreateGeometryInstanceFB
DestroyGeometryInstanceFB: ProcDestroyGeometryInstanceFB
GeometryInstanceSetTransformFB: ProcGeometryInstanceSetTransformFB
QuerySpacesFB: ProcQuerySpacesFB
RetrieveSpaceQueryResultsFB: ProcRetrieveSpaceQueryResultsFB
SaveSpaceFB: ProcSaveSpaceFB
EraseSpaceFB: ProcEraseSpaceFB
GetSpaceContainerFB: ProcGetSpaceContainerFB
GetSpaceBoundingBox2DFB: ProcGetSpaceBoundingBox2DFB
GetSpaceBoundingBox3DFB: ProcGetSpaceBoundingBox3DFB
GetSpaceSemanticLabelsFB: ProcGetSpaceSemanticLabelsFB
GetSpaceBoundary2DFB: ProcGetSpaceBoundary2DFB
GetSpaceRoomLayoutFB: ProcGetSpaceRoomLayoutFB
PassthroughLayerSetKeyboardHandsIntensityFB: ProcPassthroughLayerSetKeyboardHandsIntensityFB
CreateSpatialAnchorStoreConnectionMSFT: ProcCreateSpatialAnchorStoreConnectionMSFT
DestroySpatialAnchorStoreConnectionMSFT: ProcDestroySpatialAnchorStoreConnectionMSFT
PersistSpatialAnchorMSFT: ProcPersistSpatialAnchorMSFT
EnumeratePersistedSpatialAnchorNamesMSFT: ProcEnumeratePersistedSpatialAnchorNamesMSFT
CreateSpatialAnchorFromPersistedNameMSFT: ProcCreateSpatialAnchorFromPersistedNameMSFT
UnpersistSpatialAnchorMSFT: ProcUnpersistSpatialAnchorMSFT
ClearSpatialAnchorStoreMSFT: ProcClearSpatialAnchorStoreMSFT
CreateFacialTrackerHTC: ProcCreateFacialTrackerHTC
DestroyFacialTrackerHTC: ProcDestroyFacialTrackerHTC
GetFacialExpressionsHTC: ProcGetFacialExpressionsHTC
CreatePassthroughHTC: ProcCreatePassthroughHTC
DestroyPassthroughHTC: ProcDestroyPassthroughHTC
EnumerateViveTrackerPathsHTCX: ProcEnumerateViveTrackerPathsHTCX
SetMarkerTrackingVARJO: ProcSetMarkerTrackingVARJO
SetMarkerTrackingTimeoutVARJO: ProcSetMarkerTrackingTimeoutVARJO
SetMarkerTrackingPredictionVARJO: ProcSetMarkerTrackingPredictionVARJO
GetMarkerSizeVARJO: ProcGetMarkerSizeVARJO
CreateMarkerSpaceVARJO: ProcCreateMarkerSpaceVARJO
SetDigitalLensControlALMALENCE: ProcSetDigitalLensControlALMALENCE
SetViewOffsetVARJO: ProcSetViewOffsetVARJO
EnumeratePerformanceMetricsCounterPathsMETA: ProcEnumeratePerformanceMetricsCounterPathsMETA
SetPerformanceMetricsStateMETA: ProcSetPerformanceMetricsStateMETA
GetPerformanceMetricsStateMETA: ProcGetPerformanceMetricsStateMETA
QueryPerformanceMetricsCounterMETA: ProcQueryPerformanceMetricsCounterMETA
ApplyFoveationHTC: ProcApplyFoveationHTC
