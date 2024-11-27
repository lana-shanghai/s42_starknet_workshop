/// Write a program that returns a base64 encoded input

use core::num::traits::zero::Zero;

fn ex02(input: Array<felt252>) -> Array<felt252> {
    let encoded = Base64Impl::encode(input.span());
    return encoded;
}

pub trait Base64<T> {
    fn encode(self: Span<T>) -> Array<T>;
}

impl Base64Impl of Base64<felt252> {
    fn encode(self: Span<felt252>) -> Array<felt252> {
        // Initalize the array you will return in the end
        let mut ret: Array<felt252> = array![];

        // If self is empty, do an early return
        if (self.is_empty()) {
            return ret;
        }

        let mut i: usize = 0;

        let mut word: u256 = (*self[i]).into();
        let mut word_len: u256 = get_word_len(word);

        let mut byte1: u8 = 0;
        let mut byte2: u8 = 0;
        let mut byte3: u8 = 0;

        let mut encoded_word: u256 = 0;
        let mut encoded_word_len: u8 = 0;

        let mut padding: u8 = 3;

        let char_set = get_base64_char_set().span();

        loop {
            // get next word if needed
            while word.is_zero() {
                i += 1;

                // stop loop
                if (self.len() == i) {
                    break;
                }

                word = (*self[i]).into();
            };
            if word.is_zero() {
                break;
            }

            word_len = get_word_len(word);

            if (padding == 3) {
                byte1 = extract_byte_from_word(ref :word, ref :word_len);
                padding -= 1;
            } else if (padding == 2) {
                byte2 = extract_byte_from_word(ref :word, ref :word_len);
                padding -= 1;
            } else if (padding == 1) {
                byte3 = extract_byte_from_word(ref :word, ref :word_len);

                encoded_word = encoded_word * 0x100000000
                    + compute_base64_word(:byte1, :byte2, :byte3, :char_set).into();
                encoded_word_len += 4;

                // push to ret if another u32 encoded_word could lead to a felt252 overflow
                if (encoded_word_len + 4 > 31) {
                    ret.append(encoded_word.try_into().unwrap());

                    encoded_word = 0;
                    encoded_word_len = 0;
                }

                // reset
                byte1 = 0;
                byte2 = 0;
                byte3 = 0;
                padding = 3;
            };
        };

        // handle padding
        if (padding < 3) {
            let last_encoded_word32: u256 = compute_base64_word(:byte1, :byte2, :byte3, :char_set)
                .into();

            if (padding == 1) {
                encoded_word = encoded_word * 0x100000000
                    + (last_encoded_word32 & 0xffffff00)
                    + '=';
            } else if (padding == 2) {
                encoded_word = encoded_word * 0x100000000
                    + (last_encoded_word32 & 0xffff0000)
                    + '==';
            }
        }

        // push last encoded_words
        if (encoded_word.is_non_zero()) {
            ret.append(encoded_word.try_into().unwrap());
        }

        ret
    }
}

// pass word len for optimization purpose
fn extract_byte_from_word(ref word: u256, ref word_len: u256) -> u8 {
    if (word.is_zero()) {
        return 0;
    }

    word_len /= 0x100;

    let ret: u8 = (word / word_len).try_into().unwrap(); // can panic if word_len is not valid

    // update word
    word = word & (word_len - 1);

    ret
}

fn get_word_len(word: u256) -> u256 {
    if (word.is_zero()) {
        1
    } else {
        get_word_len(word / 0x100) * 0x100 // 1 byte shr
    }
}

fn compute_base64_word(byte1: u8, byte2: u8, byte3: u8, char_set: Span<u8>) -> u32 {
    // 6 bit cutting
    let n1 = byte1 / 0x4;
    let n2 = (byte1 & 0b11) * 0x10 + byte2 / 0x10;
    let n3 = (byte2 & 0b1111) * 0x4 + byte3 / 0x40;
    let n4 = byte3 & 0b111111;

    // base64 word construction
    let ret: u32 = (*char_set[n1.into()]).into() * 0x1000000
        + (*char_set[n2.into()]).into() * 0x10000
        + (*char_set[n3.into()]).into() * 0x100
        + (*char_set[n4.into()]).into();

    ret
}

fn get_base64_char_set() -> Array<u8> {
    array![
        'A',
        'B',
        'C',
        'D',
        'E',
        'F',
        'G',
        'H',
        'I',
        'J',
        'K',
        'L',
        'M',
        'N',
        'O',
        'P',
        'Q',
        'R',
        'S',
        'T',
        'U',
        'V',
        'W',
        'X',
        'Y',
        'Z',
        'a',
        'b',
        'c',
        'd',
        'e',
        'f',
        'g',
        'h',
        'i',
        'j',
        'k',
        'l',
        'm',
        'n',
        'o',
        'p',
        'q',
        'r',
        's',
        't',
        'u',
        'v',
        'w',
        'x',
        'y',
        'z',
        '0',
        '1',
        '2',
        '3',
        '4',
        '5',
        '6',
        '7',
        '8',
        '9',
        '+',
        '/',
    ]
}
