def impose(sig_size, total_size, fill=0):
    # fill can be any page number, preferably blank page
    if sig_size % 4 != 0:
        return "Signature size must be a multiple of 4"
    # round to the nearest greater signature
    round_size = min(n for n in range(0, total_size + sig_size, sig_size) if n >= total_size)
    lst = []
    # create signature ordering
    for sig in range(sig_size, round_size + 1, sig_size):
        start = sig - sig_size
        mid = sig - sig_size // 2
        end = sig
        section = zip(range(end,       mid + 1, -2),
                      range(start + 1, mid,      2),
                      range(start + 2, mid + 1,  2),
                      range(end - 1,   mid,     -2))
        # flatten zip and append
        lst.append(e for t in section for e in t)
    # flatten list
    flat_lst = (e for t in lst for e in t)
    # replace added pages
    return [n if n <= total_size else fill for n in flat_lst]
