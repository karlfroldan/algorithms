use std::cmp::max;
use std::env::args;

struct PriceTable {
    table: Vec<isize>,
}

fn main() {
    let p_table = PriceTable::new();
    let m = args().nth(1).expect("no integer given");
    let m: usize = m.parse().unwrap();
    let n = cut_rod(m, &p_table);
    println!("optimal price is: ${}.00", n);
}

fn cut_rod(n : usize, table: &PriceTable) -> isize {
    /*  We have the recurrence
        r_n = max(p_1, r_1 + r_{n-1}, r_2 + r_{n - 2}, ... , r_{n - 1} + r_1) */
    match n {
        // Let the base case be p_0 = 0
        0 => 0,
        // else
        _  => {
            let mut m = -1000;
            for i in 0..n {
                // Let's compare m
                // and table[i] + p_{n - i}
                // we do i + 1 to compensate for the 0 indexing
                // and the fact that 0..n is inclusive of n.
                m = max(m, table.get(i) + cut_rod(n - (i + 1), table));
            }
            m
        }
    }
}

impl PriceTable {
    fn new() -> PriceTable {
        let v = vec![1, 5, 8, 9, 10, 17, 17, 20, 24, 30];

        PriceTable {
            table: v,
        }
    }

    fn get(&self, n: usize) -> isize {
        self.table[n]
    }
}