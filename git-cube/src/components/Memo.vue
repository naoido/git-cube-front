<template>
    <div width="100%" height="400px">
        <v-card
            width="100%"
            height="calc(100vh/2-25px)"
            style="max-height: 400px;"
            color="#272727DD"
        >   
            <v-text-field
                hide-details="auto"
                label="Input note here"
                width="400px"
                style="z-index: 10;"
                v-model="input"
                :disabled="isDisabled"
                @compositionstart="isComposing = true"
                @compositionend="isComposing = false"
                @keydown.enter="handleEnter"
            />
            <div id="notes">
                <MemoModel 
                    v-for="note in notes"
                    :message="note.message"
                    :date="note.date.toLocaleDateString('ja-JP', {month: '2-digit', day: '2-digit'})+ ' ' +note.date.toLocaleTimeString('ja-JP', { hour: '2-digit', minute: '2-digit', hour12: false })"
                />
            </div>
        </v-card>
    </div>
</template>

<script setup lang="ts">
import type { Ref } from 'vue';
import { defineProps, ref } from 'vue';

interface Props {
  addNotification: (message: string) => void;
}

const props = defineProps<Props>();

const addNotification = (message: string) => {
  props.addNotification(message);
};

type Note = {
    message: string,
    date: Date
}

const input: Ref<string> = ref('');
const isComposing = ref<boolean>(false);
const notes: Ref<Array<Note>> = ref(new Array());
notes.value = [
    {
        message: "こんにちは",
        date: new Date("2024-07-21 05:42")
    },
    {
        message: "元気です",
        date: new Date("2024-07-21 04:31")
    },
    {
        message: "こちら元気に作業しております。とても体力使っています",
        date: new Date("2024-07-21 03:23")
    },
    {
        message: "パワー",
        date: new Date("2024-07-21 02:23")
    },
    {
        message: "パワー！！！",
        date: new Date("2024-07-21 02:23")
    }
]

const isDisabled = ref<boolean>(false);

const handleEnter = (event: KeyboardEvent) => {
    if (!isComposing.value && input.value.trim()) {
        isDisabled.value = true;
        notes.value.unshift({
            message: input.value,
            date: new Date()
        });
        addNotification(input.value);
        setTimeout(() => {
            isDisabled.value = false;
        }, 3000);
        input.value = "";
    }
}
</script>

<style>
#notes {
    width: 100%;
    height: 350px;
    display: block;
    overflow-y: scroll;
}
</style>