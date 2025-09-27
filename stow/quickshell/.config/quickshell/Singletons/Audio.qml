pragma Singleton

import Quickshell
import Quickshell.Io
import Quickshell.Services.Pipewire

Singleton {
    id: root

    readonly property PwNode sink: Pipewire.defaultAudioSink
    readonly property PwNode source: Pipewire.defaultAudioSource

    readonly property bool muted: sink?.audio?.muted ?? false
    readonly property real volume: sink?.audio?.volume ?? 0

    function toggleMute(): void {
        sink.audio.muted = !sink.audio.muted;
    }

    function increaseVolume(step = 0.05) {
        if (sink?.ready && sink?.audio) {
            let newVolume = Math.min(sink.audio.volume + step, 1.0);
            setVolume(newVolume);
        }
    }

    function decreaseVolume(step = 0.05) {
        if (sink?.ready && sink?.audio) {
            let newVolume = Math.max(sink.audio.volume - step, 0.0);
            setVolume(newVolume);
        }
    }

    function setVolume(volume: real): void {
        if (sink?.ready && sink?.audio) {
            sink.audio.muted = false;
            sink.audio.volume = volume;
        }
    }

    function openAudioControls(): void {
        openAudioControlsCommand.running = true;
    }

    Process {
        id: openAudioControlsCommand
        command: ["sh", "-c", "pavucontrol"]
        running: false
    }

    PwObjectTracker {
        objects: [Pipewire.defaultAudioSink, Pipewire.defaultAudioSource]
    }
}
