pub fn merkle_root(hashes: Span<felt252>) -> felt252 {
    let len = hashes.len();

    if len == 0 {
        return 0;
    }
    if len == 1 {
        return *hashes[0];
    }

    let (_, is_odd) = core::traits::DivRem::div_rem(len, 2);
    let mut arr = hashes;
    let mut next_hashes: Array<felt252> = array![];

    while let Option::Some(v) = arr.multi_pop_front::<2>() {
        let [a, b] = (*v).unbox();
        next_hashes.append(pedersen(a, b));
    };

    if (is_odd == 1) {
        let last = *arr.pop_front().unwrap();
        next_hashes.append(pedersen(last, last));
    } else if (*hashes[len - 1] == *hashes[len - 2]) {
        // CVE-2012-2459 bug fix
        panic!("unexpected node duplication in merkle tree");
    }

    merkle_root(next_hashes.span())
}
