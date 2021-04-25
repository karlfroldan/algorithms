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
    let mut r = Vec::new();
    let mut q;
    r.resize(n + 1, -1);
    
    r[0] = 0;

    for j in 1..n + 1 {
        q = -1;
        for i in 0..j {
            q = max(q, table.get(i) + r[j - (i + 1)]);
        }
        r[j] = q 
    }
    r[n]
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