final int cnt = 500;

class Population {
    int gen = 1;
    Dot d[] = new Dot[cnt];
    Population() {
        for (int i = 0; i < cnt; ++i) 
            d[i] = new Dot(start.pos);
    }
    void newgen() {
        Arrays.sort(d, new Comparator<Dot>() {
            public int compare(Dot a, Dot b) {
                return int(a.fitness() - b.fitness() < 0);   
            }
        });
        ++gen;
        float sumfitness = 0;
        for (int i = 0; i < d.length; ++i)
            sumfitness += d[i].fitness();
        Dot baby[] = new Dot[d.length];
        float curr = 0;
        int ptr = 0;
        for (int i = 0; i < d.length; ++i) {
            float now = i * sumfitness / d.length;
            while (now >= curr + d[ptr].fitness()) {
                curr += d[ptr].fitness();
                ++ptr;
            }
            baby[i] = new Dot(start.pos);
            baby[i].brain = d[ptr].brain.copy();
                if (d[ptr].finished()) baby[i].mutate(i * 1.0 / d.length);
                baby[i].mutate(0.2);
        }
        d = baby;
    }
    int undead() {
        int ans = 0;
        for (Dot dd : d) 
            if (!dd.dead) ++ans;
        return ans;
    }
}
