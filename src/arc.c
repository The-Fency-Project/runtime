#include "../include/arc.h"
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdatomic.h>

/// Mallocs new atomic counter for fency arc 
FcyArcCtr* fcyarcctr_new() {
    FcyArcCtr* ctr = malloc(sizeof(FcyArcCtr));
    if (!ctr) {
        return ctr;
    }

    atomic_init(&ctr->ctr, 1);

    return ctr;
}

/// Updates by delta and returns previous value
uint64_t upd_delta(FcyArcCtr* ctr, uint64_t delta, bool plus) {
    if (plus) {
        uint64_t bef = atomic_fetch_add_explicit(&ctr->ctr, delta, memory_order_relaxed);
        return bef;
    } else {
        uint64_t bef = atomic_fetch_sub_explicit(&ctr->ctr, delta, memory_order_acq_rel);
        return bef;
    } 
}
