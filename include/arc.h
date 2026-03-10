#pragma once
#include <stdint.h>
#include <stdatomic.h>
#include <stdbool.h>

typedef struct FcyArcCtr {
    _Atomic uint64_t ctr;
} FcyArcCtr;

FcyArcCtr* fcyarcctr_new();
uint64_t upd_delta(FcyArcCtr* ctr, uint64_t delta, bool plus);

