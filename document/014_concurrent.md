# 并发

Swift对于结构化地编写异步和并行代码有着原生的支持。
异步：代码可以被挂起后继续执行，在等待某些操作完成的同时继续执行其他任务，而不会阻塞整个程序的执行。
并行：同时执行多个任务或操作，以提高系统的处理能力和效率。

## 定义和调用异步函数

异步函数或异步方法是一种能在运行中被挂起的特殊函数或方法。
定义一个异步函数，使用 async 关键字。
因为有`await`标记的代码可以被挂起，所以在程序中只有特定的地方才能调用异步方法或函数。

```swift
func fetchDataFromServer() async throws -> String {
    // 这里可以进行异步操作，比如网络请求
    let res = try await URLSession.shared.data(from: URL(string: "https://example.com")!)
    return String(data: res.0, encoding: .utf8) ?? ""
}

// 调用异步函数
Task.init {
    do {
        let result = try await fetchDataFromServer()
        try? await Task.sleep(nanoseconds: 2_000_000_000) // 休眠 2 秒
        print(result)
    } catch {
        print("Error: \(error)")
    }
}
```

## 异步序列（asynchronous sequence）
Swift 支持异步序列，可以在每收到一个元素后对其进行处理。

```swift
let handle = FileHandle.standardInput
for try await line in handle.bytes.lines {
    print(line)
}
```

## 并行调用异步方法

可以并行调用多个异步方法，以提高系统的处理能力和效率。
以下示例代码三次调用`downloadPhoto(named:)`都不需要等待前一次调用结束。如果系统有足够的资源，这三次调用甚至都可以同时执行。
```swift
let photos = ["img_001", "img_002", "img_003"]

func downloadPhoto(named name: String) async -> String {
    print("Downloading photo...")
    print("\(name) done")
    return "https:photo-download-url/" + name
}

func show(_ photos: [String]) {
    for photo in photos {
        print("Show photo: \(photo)")
    }
}

async let firstPhoto = downloadPhoto(named: photos[0])
async let secondPhoto = downloadPhoto(named: photos[1])
async let thirdPhoto = downloadPhoto(named: photos[2])

let thePhotos = await [firstPhoto, secondPhoto, thirdPhoto]
show(thePhotos)
```

## 任务和任务组

使用任务组可以管理一组异步任务的执行。

```swift
await withTaskGroup(of: String.self) { taskGroup in
    let photoNames = await listPhotos(inGallery: "Summer Vacation")
    for name in photoNames {
        taskGroup.addTask { await downloadPhoto(named: name) }
    }
}
```

## 非结构化并发

多个任务或进程同时执行，但他们之间的交互和调度不遵守严格的结构化模式。
与传统的结构化并发模型（如线程、进程、锁等）不同，非结构化并发更加灵活，允许任务之间的交错和交互具有更大的自由度。

```swift
func fetchData() async -> String {
    try? await Task.sleep(nanoseconds: 3 * 1_000_000_000) // 休眠 3 秒
    return "Data fetched!"
}

func dataHandler() async {
    print("Start fetching data...")
    let data = await fetchData() // 非阻塞等待异步操作完成
    print(data)
}

Task {
    await dataHandler() // 启动异步任务
}
```