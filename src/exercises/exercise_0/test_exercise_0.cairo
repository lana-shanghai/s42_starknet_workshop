use s42_starknet_workshop::exercises::exercise_0::exercise_0::hash_value;


#[test]
fn test_hash_empty() {
    let mut values_to_hash = ArrayTrait::new();

    let hash = hash_value(values_to_hash.span());

    assert!(hash == 0)
}

#[test]
fn test_hash() {
    let mut values_to_hash = ArrayTrait::new();
    values_to_hash.append(1);
    values_to_hash.append(2);
    values_to_hash.append(3);

    let hash = hash_value(values_to_hash.span());

    assert!(hash == 1294447910303984572171025620771076375510424011376201048389063849436620661373)
}

