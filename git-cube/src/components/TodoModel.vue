<template>
    <div style="display: flex; margin-top: 20px; cursor: pointer;" v-bind="props">
        <v-icon icon="mdi-radiobox-blank" style="margin: 0 10px;"/>
        <p style="font-size: 19px; border-bottom: solid 1px white;">{{ props.task }}</p>
    </div>
    <p style="font-size: 15px; margin-left: 30px; width: 300px;"> > {{ props.hint }}</p>
</template>

<script setup lang="ts">
const props = defineProps({
  task: String,
  hint: String
})
</script>