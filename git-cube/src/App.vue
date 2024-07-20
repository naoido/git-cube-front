<template>
  <v-app style="background-color: transparent;">
    <v-main>
      <Cube style="position: fixed; z-index: -100;"/>
      <TopMenuBar />
      <SideMenuBar />
      <router-view />
    </v-main>
  </v-app>
</template>

<script lang="ts" setup>
  //
</script>
