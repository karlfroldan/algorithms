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
    r.resize(n + 1, -1);

    cut_rod_aux(n, table, &mut r)
}

fn cut_rod_aux(n: usize, table: &PriceTable, r: &mut Vec<isize>) -> isize {
    let mut q;
    
    if r[n] >= 0 {
        // In case we haven't memoized r[n] yet.
        return r[n];
    } else {
        match n {
            0 => q = 0,
            _ => {
                q = -1000;
                for i in 0..n {
                    q = max(q, table.get(i) + cut_rod_aux(n - (i + 1), table, r));
                }
            }
        }
        r[n] = q;
    }
    q
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