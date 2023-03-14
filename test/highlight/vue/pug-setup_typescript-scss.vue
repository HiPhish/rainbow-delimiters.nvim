<template lang="pug">
  | ErrorLayout
  | {{ errCode }}
  | {{ $t(errMsg) }}
  a-button(type="primary" @click="goToHome") Go to home
  template#footer
    a-button(type="primary" @click="goToHome") {{ $t(errMsg) }}
</template>

<script setup lang="ts">
import { storeToRefs } from 'pinia'

import { router } from '@/router'
import { ErrorStore } from '@/stores'

const { errCode, errMsg } = storeToRefs(ErrorStore())
const { clearError } = ErrorStore()

const goToHome: () => void = async () => {
  await router.push({ name: 'router_dashboard' })
  clearError()
}
</script>

<style lang="scss" scoped>
body {
  color: red;
  background: #000;
  button {
    color: red;
    cursor: pointer;
  }
}
</style>
