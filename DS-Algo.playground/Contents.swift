import UIKit


//MARK: - STACK
public struct Stack<T>{
    fileprivate var array = [T]()

    public var isEmpty:Bool{
        return array.isEmpty
    }

    public var count:Int{
        return array.count
    }

    public mutating func push(_ element:T){
        array.append(element)
    }

    public mutating func pop() -> T?{
        return array.popLast()
    }

    public var top:T?{
        return array.last
    }

}

//MARK: - QUEUE

public struct Queue<T>{
    fileprivate var array = [T?]()

    public var isEmpty:Bool{
        return array.isEmpty
    }

    public var count: Int{
        return array.count
    }

    public mutating func enqueue(_ element: T){
        array.append(element)
    }

    public mutating func dequeue() -> T?{
        if isEmpty{
            return nil
        }
        else{
            return array.removeFirst()
        }
    }

    public var front: T?{
        return array.first ?? nil
    }
}

//MARK: - A More Efficient Queue
public struct Queue2<T>{
    fileprivate var array = [T?]()
    fileprivate var head = 0

    public var isEmpty:Bool{
        return count == 0
    }

    public var count: Int{
        return array.count - head
    }

    public mutating func enqueue(_ element: T){
        array.append(element)
    }

    public mutating func dequeue() -> T?{
        guard head < array.count , let element = array[head] else{return nil}

        array[head] = nil
        head = head + 1

        let percentage = Double(head) / Double(array.count)
        if count > 50 && percentage > 0.25{
            array.removeFirst(head)
            head = 0
        }
        return element

    }

    public var front: T?{
        return array[head] ?? nil
    }

}

//MARK: - Linked List

public class LinkedListNode<T>{
    var value: T
    var next: LinkedListNode?
    weak var previous: LinkedListNode?
    public init(value: T){
        self.value = value
    }
}

public class LinkedList<T>{
    public typealias Node = LinkedListNode<T>
    private var head: Node?
    
    public var isEmpty: Bool{
        return head == nil
    }
    
    public var first: Node?{
        return head
    }
    
    public var last: Node?{
        guard var node = head else{
            return nil
        }
        while let next = node.next{
            node = next
        }
        return node
    }
    
    public func append(value: T){
        let newNode = Node(value: value)
        if let lastNode = last{
            newNode.previous = lastNode
            lastNode.next = newNode
        }
        else{
            head = newNode
        }
    }
    
    public var count:Int{
        guard var node = head else{
            return 0
        }
        var count = 1
        while let next = node.next{
            node = next
            count = count + 1
        }
        return count
    }
    
    public func node(atIndex: Int) -> Node?{
        guard var node = head else{
            return nil
        }
        if atIndex == 0{
            return node
        }
        else{
            node = node.next!
            for _ in 1..<atIndex{
                node = node.next!
            }
            return node
        }
    }
    
    public func insert(node: Node, atIndex: Int){
        let newNode = node
        if atIndex == 0{
            newNode.next = head
            head?.previous = newNode
            head = newNode
        }
        else{
            let prev = self.node(atIndex: atIndex - 1)
            let next = prev?.next
            
            prev?.next = newNode
            newNode.previous = prev
            newNode.next = next
            next?.previous = newNode
        }
    }
    
    public func removeAll() {
       head = nil
     }
    
    public func remove(node: Node) -> T{
        let prev = node.previous
        let next = node.next
        
        if let prev = prev{
            prev.next = next
        }
        else{
            head = next
        }
        
        next?.previous = prev
        node.previous = nil
        node.next = nil
        return node.value
    }
    
    public func reverse(){
       var node = head
        
        while let currentNode = node{
            node = currentNode.next
            swap(&currentNode.next, &currentNode.previous)
            head = currentNode
        }
    }
}


func binarySearch<T: Comparable>(_ a: [T],key: T, range: Range<Int>) -> Int?{
    if range.lowerBound >= range.upperBound{
        return nil
    }
    let midIndex = range.lowerBound + (range.upperBound - range.lowerBound) / 2
    
    if a[midIndex] > key{
        return binarySearch(a, key: key, range: range.lowerBound ..< midIndex)
    }
    else if a[midIndex] < key{
        return binarySearch(a, key: key, range: midIndex + 1 ..< range.upperBound)
    }
    else{
        return midIndex
    }
}
//O(log n)


func insertionSort(_ array: [Int]) -> [Int] {
    var sortedArray = array
    for i in 0..<sortedArray.count{
        for j in 1..<sortedArray.count{
            if sortedArray[i] > sortedArray[j]{
                sortedArray.swapAt(i, j)
            }
        }
    }
    return sortedArray
}
// O(n2)


