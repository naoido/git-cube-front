<template>
    <v-card color="transparent">
        <v-card-text 
            style="font-size: 20px; max-width: 400px; padding-bottom: 25px; color: #ffffffDD;"
        >
            {{ props.message }}
        </v-card-text>
        <p 
            style="text-align: end; bottom: 0px; right: 10px; position: absolute; color: #ffffff88;"
        >
            {{ props.date }}
        </p>
    </v-card>
</template>

<script setup lang="ts">
const props = defineProps({
  message: String,
  date: String
})
</script>