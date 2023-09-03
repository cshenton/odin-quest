package openxr

// Link just the proc address loader
// when ODIN_OS == .Windows {
// 	foreign import openxr_loader "openxr_loader.lib"
// } else 
// {
	foreign import openxr_loader "libopenxr_loader.so"
// }

foreign openxr_loader {
	@(link_name = "xrGetInstanceProcAddr")
	GetInstanceProcAddr :: proc "system" (
		instance: Instance,
		name: cstring,
		function: ^ProcVoidFunction,
	) -> Result ---
}

// Loads all the base procedures which don't require an instance
load_base_procs :: proc() {
	out_function : ProcVoidFunction

	GetInstanceProcAddr(nil, "xrCreateInstance", &out_function)
	CreateInstance = auto_cast out_function
	GetInstanceProcAddr(nil, "xrEnumerateApiLayerProperties", &out_function)
	EnumerateApiLayerProperties = auto_cast out_function
	GetInstanceProcAddr(nil, "xrEnumerateInstanceExtensionProperties", &out_function)
	EnumerateInstanceExtensionProperties = auto_cast out_function
}


// Load all the instance procedures
load_instance_procs :: proc(instance: Instance) {
        out_function : ProcVoidFunction

	GetInstanceProcAddr(instance, "xrDestroyInstance", &out_function)
	DestroyInstance = auto_cast out_function
	GetInstanceProcAddr(instance, "xrResultToString", &out_function)
	ResultToString = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStructureTypeToString", &out_function)
	StructureTypeToString = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetInstanceProperties", &out_function)
	GetInstanceProperties = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSystem", &out_function)
	GetSystem = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSystemProperties", &out_function)
	GetSystemProperties = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSession", &out_function)
	CreateSession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySession", &out_function)
	DestroySession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpace", &out_function)
	DestroySpace = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSwapchainFormats", &out_function)
	EnumerateSwapchainFormats = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSwapchain", &out_function)
	CreateSwapchain = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySwapchain", &out_function)
	DestroySwapchain = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSwapchainImages", &out_function)
	EnumerateSwapchainImages = auto_cast out_function
	GetInstanceProcAddr(instance, "xrAcquireSwapchainImage", &out_function)
	AcquireSwapchainImage = auto_cast out_function
	GetInstanceProcAddr(instance, "xrWaitSwapchainImage", &out_function)
	WaitSwapchainImage = auto_cast out_function
	GetInstanceProcAddr(instance, "xrReleaseSwapchainImage", &out_function)
	ReleaseSwapchainImage = auto_cast out_function
	GetInstanceProcAddr(instance, "xrBeginSession", &out_function)
	BeginSession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEndSession", &out_function)
	EndSession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestExitSession", &out_function)
	RequestExitSession = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateReferenceSpaces", &out_function)
	EnumerateReferenceSpaces = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateReferenceSpace", &out_function)
	CreateReferenceSpace = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateActionSpace", &out_function)
	CreateActionSpace = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateSpace", &out_function)
	LocateSpace = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateViewConfigurations", &out_function)
	EnumerateViewConfigurations = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateEnvironmentBlendModes", &out_function)
	EnumerateEnvironmentBlendModes = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetViewConfigurationProperties", &out_function)
	GetViewConfigurationProperties = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateViewConfigurationViews", &out_function)
	EnumerateViewConfigurationViews = auto_cast out_function
	GetInstanceProcAddr(instance, "xrBeginFrame", &out_function)
	BeginFrame = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateViews", &out_function)
	LocateViews = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEndFrame", &out_function)
	EndFrame = auto_cast out_function
	GetInstanceProcAddr(instance, "xrWaitFrame", &out_function)
	WaitFrame = auto_cast out_function
	GetInstanceProcAddr(instance, "xrApplyHapticFeedback", &out_function)
	ApplyHapticFeedback = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStopHapticFeedback", &out_function)
	StopHapticFeedback = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPollEvent", &out_function)
	PollEvent = auto_cast out_function
	GetInstanceProcAddr(instance, "xrStringToPath", &out_function)
	StringToPath = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPathToString", &out_function)
	PathToString = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetReferenceSpaceBoundsRect", &out_function)
	GetReferenceSpaceBoundsRect = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetAndroidApplicationThreadKHR", &out_function)
	SetAndroidApplicationThreadKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSwapchainAndroidSurfaceKHR", &out_function)
	CreateSwapchainAndroidSurfaceKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetActionStateBoolean", &out_function)
	GetActionStateBoolean = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetActionStateFloat", &out_function)
	GetActionStateFloat = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetActionStateVector2f", &out_function)
	GetActionStateVector2f = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetActionStatePose", &out_function)
	GetActionStatePose = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateActionSet", &out_function)
	CreateActionSet = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyActionSet", &out_function)
	DestroyActionSet = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateAction", &out_function)
	CreateAction = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyAction", &out_function)
	DestroyAction = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSuggestInteractionProfileBindings", &out_function)
	SuggestInteractionProfileBindings = auto_cast out_function
	GetInstanceProcAddr(instance, "xrAttachSessionActionSets", &out_function)
	AttachSessionActionSets = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetCurrentInteractionProfile", &out_function)
	GetCurrentInteractionProfile = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSyncActions", &out_function)
	SyncActions = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateBoundSourcesForAction", &out_function)
	EnumerateBoundSourcesForAction = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetInputSourceLocalizedName", &out_function)
	GetInputSourceLocalizedName = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanInstanceExtensionsKHR", &out_function)
	GetVulkanInstanceExtensionsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanDeviceExtensionsKHR", &out_function)
	GetVulkanDeviceExtensionsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanGraphicsDeviceKHR", &out_function)
	GetVulkanGraphicsDeviceKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetOpenGLGraphicsRequirementsKHR", &out_function)
	GetOpenGLGraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetOpenGLESGraphicsRequirementsKHR", &out_function)
	GetOpenGLESGraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanGraphicsRequirementsKHR", &out_function)
	GetVulkanGraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetD3D11GraphicsRequirementsKHR", &out_function)
	GetD3D11GraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetD3D12GraphicsRequirementsKHR", &out_function)
	GetD3D12GraphicsRequirementsKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPerfSettingsSetPerformanceLevelEXT", &out_function)
	PerfSettingsSetPerformanceLevelEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrThermalGetTemperatureTrendEXT", &out_function)
	ThermalGetTemperatureTrendEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetDebugUtilsObjectNameEXT", &out_function)
	SetDebugUtilsObjectNameEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateDebugUtilsMessengerEXT", &out_function)
	CreateDebugUtilsMessengerEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyDebugUtilsMessengerEXT", &out_function)
	DestroyDebugUtilsMessengerEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSubmitDebugUtilsMessageEXT", &out_function)
	SubmitDebugUtilsMessageEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSessionBeginDebugUtilsLabelRegionEXT", &out_function)
	SessionBeginDebugUtilsLabelRegionEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSessionEndDebugUtilsLabelRegionEXT", &out_function)
	SessionEndDebugUtilsLabelRegionEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSessionInsertDebugUtilsLabelEXT", &out_function)
	SessionInsertDebugUtilsLabelEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrConvertTimeToWin32PerformanceCounterKHR", &out_function)
	ConvertTimeToWin32PerformanceCounterKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrConvertWin32PerformanceCounterToTimeKHR", &out_function)
	ConvertWin32PerformanceCounterToTimeKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateVulkanInstanceKHR", &out_function)
	CreateVulkanInstanceKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateVulkanDeviceKHR", &out_function)
	CreateVulkanDeviceKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanGraphicsDevice2KHR", &out_function)
	GetVulkanGraphicsDevice2KHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVulkanGraphicsRequirements2KHR", &out_function)
	GetVulkanGraphicsRequirements2KHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrConvertTimeToTimespecTimeKHR", &out_function)
	ConvertTimeToTimespecTimeKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrConvertTimespecTimeToTimeKHR", &out_function)
	ConvertTimespecTimeToTimeKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetVisibilityMaskKHR", &out_function)
	GetVisibilityMaskKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorMSFT", &out_function)
	CreateSpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorSpaceMSFT", &out_function)
	CreateSpatialAnchorSpaceMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialAnchorMSFT", &out_function)
	DestroySpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceActiveEXT", &out_function)
	SetInputDeviceActiveEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceStateBoolEXT", &out_function)
	SetInputDeviceStateBoolEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceStateFloatEXT", &out_function)
	SetInputDeviceStateFloatEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceStateVector2fEXT", &out_function)
	SetInputDeviceStateVector2fEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetInputDeviceLocationEXT", &out_function)
	SetInputDeviceLocationEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrInitializeLoaderKHR", &out_function)
	InitializeLoaderKHR = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialGraphNodeSpaceMSFT", &out_function)
	CreateSpatialGraphNodeSpaceMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTryCreateSpatialGraphStaticNodeBindingMSFT", &out_function)
	TryCreateSpatialGraphStaticNodeBindingMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialGraphNodeBindingMSFT", &out_function)
	DestroySpatialGraphNodeBindingMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpatialGraphNodeBindingPropertiesMSFT", &out_function)
	GetSpatialGraphNodeBindingPropertiesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateHandTrackerEXT", &out_function)
	CreateHandTrackerEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyHandTrackerEXT", &out_function)
	DestroyHandTrackerEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateHandJointsEXT", &out_function)
	LocateHandJointsEXT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateHandMeshSpaceMSFT", &out_function)
	CreateHandMeshSpaceMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateHandMeshMSFT", &out_function)
	UpdateHandMeshMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetControllerModelKeyMSFT", &out_function)
	GetControllerModelKeyMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLoadControllerModelMSFT", &out_function)
	LoadControllerModelMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetControllerModelPropertiesMSFT", &out_function)
	GetControllerModelPropertiesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetControllerModelStateMSFT", &out_function)
	GetControllerModelStateMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSceneComputeFeaturesMSFT", &out_function)
	EnumerateSceneComputeFeaturesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSceneObserverMSFT", &out_function)
	CreateSceneObserverMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySceneObserverMSFT", &out_function)
	DestroySceneObserverMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSceneMSFT", &out_function)
	CreateSceneMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySceneMSFT", &out_function)
	DestroySceneMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrComputeNewSceneMSFT", &out_function)
	ComputeNewSceneMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSceneComputeStateMSFT", &out_function)
	GetSceneComputeStateMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSceneComponentsMSFT", &out_function)
	GetSceneComponentsMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLocateSceneComponentsMSFT", &out_function)
	LocateSceneComponentsMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSceneMeshBuffersMSFT", &out_function)
	GetSceneMeshBuffersMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDeserializeSceneMSFT", &out_function)
	DeserializeSceneMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSerializedSceneFragmentDataMSFT", &out_function)
	GetSerializedSceneFragmentDataMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateDisplayRefreshRatesFB", &out_function)
	EnumerateDisplayRefreshRatesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetDisplayRefreshRateFB", &out_function)
	GetDisplayRefreshRateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRequestDisplayRefreshRateFB", &out_function)
	RequestDisplayRefreshRateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorFromPerceptionAnchorMSFT", &out_function)
	CreateSpatialAnchorFromPerceptionAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTryGetPerceptionAnchorFromSpatialAnchorMSFT", &out_function)
	TryGetPerceptionAnchorFromSpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUpdateSwapchainFB", &out_function)
	UpdateSwapchainFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSwapchainStateFB", &out_function)
	GetSwapchainStateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateColorSpacesFB", &out_function)
	EnumerateColorSpacesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetColorSpaceFB", &out_function)
	SetColorSpaceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFoveationProfileFB", &out_function)
	CreateFoveationProfileFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFoveationProfileFB", &out_function)
	DestroyFoveationProfileFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetHandMeshFB", &out_function)
	GetHandMeshFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateRenderModelPathsFB", &out_function)
	EnumerateRenderModelPathsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetRenderModelPropertiesFB", &out_function)
	GetRenderModelPropertiesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrLoadRenderModelFB", &out_function)
	LoadRenderModelFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySystemTrackedKeyboardFB", &out_function)
	QuerySystemTrackedKeyboardFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateKeyboardSpaceFB", &out_function)
	CreateKeyboardSpaceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetEnvironmentDepthEstimationVARJO", &out_function)
	SetEnvironmentDepthEstimationVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateReprojectionModesMSFT", &out_function)
	EnumerateReprojectionModesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetAudioOutputDeviceGuidOculus", &out_function)
	GetAudioOutputDeviceGuidOculus = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetAudioInputDeviceGuidOculus", &out_function)
	GetAudioInputDeviceGuidOculus = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorFB", &out_function)
	CreateSpatialAnchorFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceUuidFB", &out_function)
	GetSpaceUuidFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateSpaceSupportedComponentsFB", &out_function)
	EnumerateSpaceSupportedComponentsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetSpaceComponentStatusFB", &out_function)
	SetSpaceComponentStatusFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceComponentStatusFB", &out_function)
	GetSpaceComponentStatusFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateTriangleMeshFB", &out_function)
	CreateTriangleMeshFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyTriangleMeshFB", &out_function)
	DestroyTriangleMeshFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshGetVertexBufferFB", &out_function)
	TriangleMeshGetVertexBufferFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshGetIndexBufferFB", &out_function)
	TriangleMeshGetIndexBufferFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshBeginUpdateFB", &out_function)
	TriangleMeshBeginUpdateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshEndUpdateFB", &out_function)
	TriangleMeshEndUpdateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshBeginVertexBufferUpdateFB", &out_function)
	TriangleMeshBeginVertexBufferUpdateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrTriangleMeshEndVertexBufferUpdateFB", &out_function)
	TriangleMeshEndVertexBufferUpdateFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePassthroughFB", &out_function)
	CreatePassthroughFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPassthroughFB", &out_function)
	DestroyPassthroughFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughStartFB", &out_function)
	PassthroughStartFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughPauseFB", &out_function)
	PassthroughPauseFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePassthroughLayerFB", &out_function)
	CreatePassthroughLayerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPassthroughLayerFB", &out_function)
	DestroyPassthroughLayerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughLayerPauseFB", &out_function)
	PassthroughLayerPauseFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughLayerResumeFB", &out_function)
	PassthroughLayerResumeFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughLayerSetStyleFB", &out_function)
	PassthroughLayerSetStyleFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateGeometryInstanceFB", &out_function)
	CreateGeometryInstanceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyGeometryInstanceFB", &out_function)
	DestroyGeometryInstanceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGeometryInstanceSetTransformFB", &out_function)
	GeometryInstanceSetTransformFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQuerySpacesFB", &out_function)
	QuerySpacesFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrRetrieveSpaceQueryResultsFB", &out_function)
	RetrieveSpaceQueryResultsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSaveSpaceFB", &out_function)
	SaveSpaceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEraseSpaceFB", &out_function)
	EraseSpaceFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceContainerFB", &out_function)
	GetSpaceContainerFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceBoundingBox2DFB", &out_function)
	GetSpaceBoundingBox2DFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceBoundingBox3DFB", &out_function)
	GetSpaceBoundingBox3DFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceSemanticLabelsFB", &out_function)
	GetSpaceSemanticLabelsFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceBoundary2DFB", &out_function)
	GetSpaceBoundary2DFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetSpaceRoomLayoutFB", &out_function)
	GetSpaceRoomLayoutFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPassthroughLayerSetKeyboardHandsIntensityFB", &out_function)
	PassthroughLayerSetKeyboardHandsIntensityFB = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorStoreConnectionMSFT", &out_function)
	CreateSpatialAnchorStoreConnectionMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroySpatialAnchorStoreConnectionMSFT", &out_function)
	DestroySpatialAnchorStoreConnectionMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrPersistSpatialAnchorMSFT", &out_function)
	PersistSpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumeratePersistedSpatialAnchorNamesMSFT", &out_function)
	EnumeratePersistedSpatialAnchorNamesMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateSpatialAnchorFromPersistedNameMSFT", &out_function)
	CreateSpatialAnchorFromPersistedNameMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrUnpersistSpatialAnchorMSFT", &out_function)
	UnpersistSpatialAnchorMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrClearSpatialAnchorStoreMSFT", &out_function)
	ClearSpatialAnchorStoreMSFT = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateFacialTrackerHTC", &out_function)
	CreateFacialTrackerHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyFacialTrackerHTC", &out_function)
	DestroyFacialTrackerHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetFacialExpressionsHTC", &out_function)
	GetFacialExpressionsHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreatePassthroughHTC", &out_function)
	CreatePassthroughHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrDestroyPassthroughHTC", &out_function)
	DestroyPassthroughHTC = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumerateViveTrackerPathsHTCX", &out_function)
	EnumerateViveTrackerPathsHTCX = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetMarkerTrackingVARJO", &out_function)
	SetMarkerTrackingVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetMarkerTrackingTimeoutVARJO", &out_function)
	SetMarkerTrackingTimeoutVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetMarkerTrackingPredictionVARJO", &out_function)
	SetMarkerTrackingPredictionVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetMarkerSizeVARJO", &out_function)
	GetMarkerSizeVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrCreateMarkerSpaceVARJO", &out_function)
	CreateMarkerSpaceVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetDigitalLensControlALMALENCE", &out_function)
	SetDigitalLensControlALMALENCE = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetViewOffsetVARJO", &out_function)
	SetViewOffsetVARJO = auto_cast out_function
	GetInstanceProcAddr(instance, "xrEnumeratePerformanceMetricsCounterPathsMETA", &out_function)
	EnumeratePerformanceMetricsCounterPathsMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrSetPerformanceMetricsStateMETA", &out_function)
	SetPerformanceMetricsStateMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrGetPerformanceMetricsStateMETA", &out_function)
	GetPerformanceMetricsStateMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrQueryPerformanceMetricsCounterMETA", &out_function)
	QueryPerformanceMetricsCounterMETA = auto_cast out_function
	GetInstanceProcAddr(instance, "xrApplyFoveationHTC", &out_function)
	ApplyFoveationHTC = auto_cast out_function
}

