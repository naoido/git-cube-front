<template>
    <v-card
        height="300px"
        width="300px"
        color="success"
        border="xl"
    >
        <img :src="generateImgPath(String(props.cubeId))"/>
        <div style="position: absolute; bottom: 10px; width: 100%; display: flex; justify-content: center; align-items: center; flex-direction: column;">
            <p style="background-color: #272727; padding: 0 10px; margin-bottom: 10px;">{{ props.cubeName }}</p>
            <v-btn color="success" width="100px" @click="select">
                選択
            </v-btn>
        </div>
    </v-card>
</template>

<script setup lang="ts">
const props = defineProps({
    cubeId: Number,
    cubeName: String,
})

const generateImgPath = (fileName: string): string => {
  return new URL(`../assets/images/${fileName}.jpg`, import.meta.url).href
}

const select = () => {
    console.log(props.cubeId);
}
</script>