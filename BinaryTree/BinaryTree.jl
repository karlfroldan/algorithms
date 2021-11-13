module BinaryTree

    export new_tree, subtree_insert_right!, subtree_insert_left!, Node, print_tree
    export successor, predecessor, subtree_delete!

    mutable struct Node{T}
        # We can use depth for printing
        depth   :: Int
        item    :: T 
        parent  :: Union{Node{T}, Nothing}
        left    :: Union{Node{T}, Nothing}
        right   :: Union{Node{T}, Nothing}
    end

    mutable struct BinTree{T}
        root :: Union{Node{T}, Nothing}
    end

    

    function new_tree(item :: T) where T <: Any
        node = Node(0, item, nothing, nothing, nothing)
        return BinTree{T}(node)
    end

    hasright(node::Node{T}) where T <: Any = node.right ≠ nothing 
    hasleft(node::Node{T}) where T<: Any = node.left ≠ nothing
    hasparent(node::Node{T}) where T <: Any = node.parent ≠ nothing
    isleaf(node::Node{T}) where T <: Any = node.left ≠ nothing & node.right ≠ nothing

    function preorder_traversal(node :: Union{Nothing, Node{T}}, f::Function) where T <: Any 
        f(node)

        if node ≠ nothing 
            preorder_traversal(node.left, f)
            preorder_traversal(node.right, f)
        end
    end

    function pretty(node :: Union{Nothing, Node{T}}) where T <: Any 
        depth = (node === nothing) ? 0 : node.depth

        
        if node ≠ nothing 
            print_string = (" " ^ ((depth + 1) * 2)) * "- " 
            print_string = print_string * string(node.item)
            println(print_string)
        end
        
        
    end

    function print_tree(tree :: BinTree{T}) where T <: Any 
        preorder_traversal(tree.root, pretty)
    end

    function successor(node::Node{T}) where T <: Any 
        if hasright(node)
            hasright(node) && (w = node.right)

            while hasleft(w)
                w = w.left 
            end

            return w
        elseif node.parent ≠ nothing 
            w = node.parent 

            while w.parent.left ≠ w 
                w = w.parent 
            end

            return w
        else 
            return nothing
        end
    end

    function predecessor(node::Node{T}) where T <: Any 
        if hasleft(node)
            hasleft(node) && (w = node.left)

            while hasright(w)
                w = w.left 
            end

            return w
        elseif node.parent ≠ nothing 
            w = node.parent 

            while w.parent.right ≠ w 
                w = w.parent 
            end

            return w
        else 
            return nothing
        end
    end

    function subtree_insert_right!(node::Node{T}, new::Node{T}) where T <: Any
        # Case 1, 
        #   If no node.right, put new there 
        # Case 2,
        #   If node.right exists, place new to the leftmost descendant of node.right 
        if !hasright(node)
            new.depth = node.depth + 1
            new.parent = node 
            node.right = new 
        else 
            descendant = node.right 

            while hasleft(descendant)
                descendant = descendant.left 
            end

            new.depth = descendant.depth + 1
            new.parent = descendant 
            descendant.left = new
        end
    end

    function subtree_insert_left!(node::Node{T}, new::Node{T}) where T <: Any 
        if !hasleft(node)
            new.depth = node.depth + 1 
            new.parent = node 
            node.left = new 
        else 
            descendant = node.left 

            while hasright(descendant)
                descendant = descendant.right 
            end 

            new.depth = descendant.depth + 1 
            new.parent = descendant
            descendant.right = new
        end
    end

    function swapitem!(n1::Node{T}, n2::Node{T}) where T <: Any 
        temp = n1.item 
        n1.item = n2.item 
        n2.item = temp
    end

    function subtree_delete!(tree::BinTree{T}, node::Node{T}) where T <: Any 
        if isleaf(node)
            if hasparent(node)
                # Check whether node is left or right
                π = node.parent 
                if π.left === node 
                    π.left = nothing 
                else 
                    π.right = nothing 
                end 
            else 
                # node is the only vertex in the tree 
                tree.root = nothing 
            end 
        else 
            if hasleft(node)
                pre = predecessor(node)
                swapitem!(node, pre)
                subtree_delete!(tree, pre)
            elseif hasright(node) 
                suc = successor(node)
                swapitem!(node, suc)
                subtree_delete!(tree, suc)
            end
        end
    end
end