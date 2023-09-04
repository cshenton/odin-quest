package android

ALooper :: struct {
        
}

@(default_calling_convention="c")
foreign {
ALooper_pollAll :: proc(timeoutMillis: i32, outFd: ^i32, outEvents: ^i32, outData: ^rawptr) -> i32 ---
}
