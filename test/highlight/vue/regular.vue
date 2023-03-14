<template>
    ErrorLayout
    {{ errCode }}
    {{ $t(errMsg) }}
    <a-button type="primary" @click="goToHome">goToHome</a-button>
    <template #footer>
        <a-button type="primary" @click="goToHome">{{ $t(errMsg) }}</a-button>
    </template>
</template>

<script setup>
import { storeToRefs } from "pinia";

import { router } from "@/router";
import { ErrorStore } from "@/stores";

const { errCode, errMsg } = storeToRefs(ErrorStore());
const { clearError } = ErrorStore();

const goToHome = async () => {
    await router.push({ name: "router_dashboard" });
    clearError();
};
</script>

<style>
body {
    color: red;
    background: #000;
}
button {
    color: red;
    cursor: pointer;
}
</style>
