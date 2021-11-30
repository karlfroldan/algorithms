module BinarySearchTree

    include("BinaryTree.jl")

    using .BinaryTree

    export print_tree, insert_bst!
    export successor, predecessor, find
    export Node, BinTree
    export inorder_traversal, delete_bst!

    function new(item)
        new_tree(item)
    end

    function insert_bst!(tree :: BinTree{T}, item :: T) where T <: Union{Char, Number}
        if emptytree(tree)
            node = Node(0, 1, item, nothing, nothing, nothing)
            tree.root = node
        else 
            new = Node{T}(0, 1, item, nothing, nothing, nothing)

            insert_bst_aux!(tree.root, new)
        end
    end

    function insert_bst_aux!(current::Node{T}, new::Node{T}) where T <: Union{Char, Number}
        if new.item == current.item 
            # Do nothing
        elseif new.item < current.item
            if !hasleft(current)
                add_to_left!(current, new)
            else
                insert_bst_aux!(current.left, new)
            end
        else
            if !hasright(current)
                add_to_right!(current, new)
            else
                insert_bst_aux!(current.right, new)
            end
        end
    end

    function find(tree :: BinTree{T}, key :: T) where T <: Union{Char, Number}
        find_aux(tree.root, key)
    end

    function find_aux(node::Union{Nothing, Node{T}}, key :: T) where T <: Union{Char, Number}
        if node === nothing 
            return nothing
        elseif node.item == key 
            return node 
        else 
            if key <= node.item 
                find_aux(node.left, key)
            else
                find_aux(node.right, key)
            end
        end
    end

    function delete_bst!(tree :: BinTree{T}, node :: Node{T}) where T <: Union{Char, Number}
        subtree_delete!(tree, node)
    end
end