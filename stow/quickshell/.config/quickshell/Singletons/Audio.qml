pragma Singleton

import QtQuick

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource
    readonly property bool muted: sink && sink.audio ? sink.audio.muted : false
    readonly property real volume: sink && sink.audio ? sink.audio.volume : 0

    function toggleMute() {
        sink.audio.muted = !sink.audio.muted;
    }

    function increaseVolume(step = 0.05) {
        if (sink && sink.ready && sink.audio) {
            let newVolume = Math.min(sink.audio.volume + step, 1);
            setVolume(newVolume);
        }
    }

    function decreaseVolume(step = 0.05) {
        if (sink && sink.ready && sink.audio) {
            let newVolume = Math.max(sink.audio.volume - step, 0);
            setVolume(newVolume);
        }
    }

    function setVolume(volume: real) {
        if (sink && sink.ready && sink.audio) {
            sink.audio.muted = false;
            sink.audio.volume = volume;
            playSound.running = true;
        }
    }

    function openAudioControls() {
        openAudioControlsCommand.running = true;
    }

    function refreshAudioState() {
        if (sink && sink.audio) {
            let wasMuted = sink.audio.muted;
            sink.audio.muted = !wasMuted;
            sink.audio.muted = wasMuted;
        }
    }

    Process {
        id: openAudioControlsCommand

        command: ["sh", "-c", "pavucontrol"]
        running: false
    }

    Process {
        id: playSound

        command: ["pw-play", "/usr/share/sounds/freedesktop/stereo/audio-volume-change.oga"]
        running: false
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }

    Connections {
        function onVolumeChanged() {
            if (isNaN(root.sink.audio.volume))
                root.refreshAudioState();
        }

        target: root.sink ? root.sink.audio : null
    }
}
