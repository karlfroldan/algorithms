module BinaryTree

    export new_tree, subtree_insert_right!, subtree_insert_left!, Node, print_tree
    export successor, predecessor, subtree_delete!
    export BinTree, emptytree, Node
    export add_to_left!, add_to_right!
    export hasleft, hasright
    export inorder_traversal

    mutable struct Node{T}
        # We can use depth for printing
        depth   :: Int
        size    :: Int
        item    :: T 
        parent  :: Union{Node{T}, Nothing}
        left    :: Union{Node{T}, Nothing}
        right   :: Union{Node{T}, Nothing}
    end

    mutable struct BinTree{T}
        root :: Union{Node{T}, Nothing}
    end

    

    function recalculate_size!(node :: Node{T}) where T <: Any 
        left = (node.left ≠ nothing) ? node.left.size : 0
        right = (node.right ≠ nothing) ? node.right.size : 0
        node.size = left + right + 1
    end

    function recalculate_ancestors!(node :: Node{T}) where T <: Any 
        # We assume that node has the correct size 
        current = node.parent 

        while current ≠ nothing 
            recalculate_size!(current)
            current = current.parent 
        end
    end

    function children_size(node :: Node{T}) where T <: Any 
        left = (node.left ≠ nothing) ? node.left.size : 0 
        right = (node.right ≠ nothing) ? node.right.size : 0
        (left, right)
    end

    function skew(x :: Node{T}) where T <: Any 
        (left, right) = children_size(x)
        return right - left
    end

    function new_tree(item :: T) where T <: Any
        node = Node(0, 1, item, nothing, nothing, nothing)
        return BinTree{T}(node)
    end

    function add_to_left!(parent::Node{T}, child::Node{T}) where T <: Any 
        parent.left = child 
        child.parent = parent 
        child.depth = parent.depth + 1

        recalculate_ancestors!(child)

    end

    function add_to_right!(parent::Node{T}, child::Node{T}) where T <: Any 
        parent.right = child 
        child.parent = parent
        child.depth = parent.depth + 1
        
        recalculate_ancestors!(child)
    end

    emptytree(tree::BinTree{T}) where T <: Any = tree.root === nothing
    hasright(node::Node{T}) where T <: Any = node.right ≠ nothing 
    hasleft(node::Node{T}) where T<: Any = node.left ≠ nothing
    hasparent(node::Node{T}) where T <: Any = node.parent ≠ nothing
    isleaf(node::Node{T}) where T <: Any = node.left === nothing && node.right === nothing

    function inorder_traversal(node :: Union{Nothing, Node{T}}, f :: Function) where T <: Any 
        if node ≠ nothing 
            inorder_traversal(node.left, f)
            f(node)
            inorder_traversal(node.right, f)
        end
    end

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
            print_string = "|" * (" " ^ ((depth + 1) * 2)) * "- " 
            print_string = print_string * string(node.item) * " | " * string(node.size)
            print_string = print_string * " | skew = $(skew(node))"
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
            if hasright(node) 
                suc = successor(node)
                swapitem!(node, suc)
                subtree_delete!(tree, suc)
            elseif hasleft(node)
                pre = predecessor(node)
                swapitem!(node, pre)
                subtree_delete!(tree, pre)
            end
        end
    end
end