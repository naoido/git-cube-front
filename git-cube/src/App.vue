<template>
  <v-app style="background-color: transparent;">
    <v-main style="position: relative;">
      <Cube style="position: fixed; z-index: -100;"/>
      <TopMenuBar  style="position: fixed; z-index: 10;"/>
      <div id="todo">
        <Todo style="position: fixed; z-index: 10;"/>
      </div>
      <div id="memo">
        <Memo style="position: fixed; z-index: 10;" :addNotification="addNotification"/>
      </div>
      <div
        class="position-fixed w-100 d-flex justify-center" 
        style="z-index: 999; bottom: 160px; margin: 0 auto; opacity: 0.9;"
      >
        <div class="w-25 d-flex justify-center flex-column">
          <v-slide-y-transition group>
            <v-alert
              v-for="notification in notifications"
              :class="`bg-grey-lighten-5 mt-2`"
              :key="notification[0]"
              >
              {{ notification[1] }}
              </v-alert>
          </v-slide-y-transition>
        </div>
      </div>
      <div style="position: absolute; display: flex; align-items: start; padding-top: 50px; justify-content: center; width: 100vw; height: 100vh;">
        <p style="padding: 0 10px;" id="contributes">
          <span>Commit: {{ contributes.commit }}</span> | <span>PR: {{ contributes.pullRequest }}</span> | <span>Issue: {{ contributes.issue }}</span> | <span>CodeReview: {{ contributes.codeReview }}</span>
        </p>
      </div>
      <div style="display: flex; align-items: end; padding-bottom: 50px; justify-content: center; width: 100vw; height: 100vh;">
        <v-dialog v-model="cubeDisplay">
          <template v-slot:activator="{ props }">
            <div class="swap-cube" v-bind="props">
              <v-icon icon="mdi-swap-horizontal" color="#ffffff"/>
              <p style="padding-right: 24px;">
                Change my Cube
              </p>
            </div>
          </template>
          <div style="display: flex;">
            <CubeCard v-for="cube in collectedCubes" :display="cubeDisplay" :cubeId="cube[0]" :cubeName="cube[1]" style="margin: 5px;"/>
          </div>
        </v-dialog>
      </div>
    </v-main>
  </v-app>
</template>

<script lang="ts" setup>
import type { Ref } from 'vue';
import { ref } from 'vue';

type Contributes = {
  commit: Number,
  pullRequest: Number,
  issue: Number,
  codeReview: Number
}

const cubeDisplay = ref(false);
const collectedCubes: Ref<Map<Number, String>> = ref(new Map());
collectedCubes.value.set(1, "basket-sarface");
collectedCubes.value.set(8, "GARERIA001");

const notifications: Ref<Map<string, string>> = ref(new Map());
const contributes: Ref<Contributes> = ref({
  commit: 245,
  pullRequest: 54,
  issue: 10,
  codeReview: 0
});

const addNotification = (message: string) => {
  const id = crypto.randomUUID();
  notifications.value.set(id, message);

  setTimeout(() => {
    notifications.value.delete(id)
  }, 6000);
}

addNotification("こんにちは")
</script>

<style lang="scss">
#todo {
  position: absolute;
  display: flex;
  align-items: center;
  width: 400px;
  height: 100vh;
  min-height: 600px;
  top: 0;
  left: 0;
}
#memo {
  position: absolute;
  display: flex;
  align-items: center;
  width: 400px;
  height: 100vh;
  min-height: 600px;
  top: 0;
  right: 0;
}
.swap-cube {
  cursor: pointer; 
  display: flex;
  transition: all 0.5s ease;
  opacity: 1;
  transform: scale(1);
  &:hover {
    opacity: 0.7;
    transform: scale(1.1);
  }
}
#contributes {
  span {
    margin: 0 10px;
  }
}
</style>