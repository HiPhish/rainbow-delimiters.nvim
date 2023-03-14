<!-- A template element written in Pug -->

<template lang="pug">
  | ErrorLayout
  | {{ errCode }}
  | {{ $t(errMsg) }}
  a-button(type="primary" @click="goToHome") Go to home
  template#footer
    a-button(type="primary" @click="goToHome") {{ $t(errMsg) }}
</template>
