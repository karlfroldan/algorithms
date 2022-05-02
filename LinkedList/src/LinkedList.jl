module LinkedList

    export LinkList, Node, new, length, add!, print_list

    mutable struct Node{T}
        value :: T
        next :: Union{Node{T}, Nothing}
        prev :: Union{Node{T}, Nothing}
    end

    mutable struct LinkList{T}
        head :: Union{Node{T}, Nothing}
        tail :: Union{Node{T}, Nothing}
        length :: Int64
    end

    function new()
        LinkList{Any}(nothing, nothing, 0)
    end

    function length(L::LinkList{T}) where (T <: Any)
        return L.length
    end

    function add!(L::LinkList{T}, item::T) where T <: Any 
        node = Node{T}(item, nothing, nothing)

        current_node = L.head

        if current_node ≠ nothing 
            while current_node.next ≠ nothing 
                current_node = current_node.next 
            end

            current_node.next = node 
            L.tail = node
            node.prev = current_node
        else 
            L.head = node 
            L.tail = node
        end

        L.length += 1
    end

    function print_list(L::LinkList{T}) where T <: Any 
        if LinkedList.length(L) == 0 
            println("Empty list")
        else
            node = L.head
            print("[")
            while node ≠ nothing 
                print("$(node.value)")
                if node.next ≠ nothing 
                    print(", ")
                end
                node = node.next
            end
            println("]")
        end
    end
end # module
