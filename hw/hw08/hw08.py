
def deep_len(lst):
    """Returns the deep length of the list.

    >>> deep_len([1, 2, 3])     # normal list
    3
    >>> x = [1, [2, 3], 4]      # deep list
    >>> deep_len(x)
    4
    >>> x = [[1, [1, 1]], 1, [1, 1]] # deep list
    >>> deep_len(x)
    6
    >>> x = []
    >>> for i in range(100):
    ...     x = [x] + [i]       # very deep list
    ...
    >>> deep_len(x)
    100
    """
    # if not lst:
    #     return 0
    # elif type(lst[0]) == list:
    #     return deep_len(lst[0]) + deep_len(lst[1:])
    # else:
    #     return 1 + deep_len(lst[1:])

    if type(lst) != list:
        return 1
    return sum(deep_len(elem) for elem in lst)