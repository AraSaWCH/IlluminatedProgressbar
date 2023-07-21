﻿// Copyright (C) 2022 smr.
// SPDX-License-Identifier: MIT
// https://smr76.github.io

import QtQuick 2.15
import QtGraphicalEffects 1.0
import Neumorphism 1.0

// RoundedOutEffect.qml

Item {
    id: control

    property alias shadow: shadowEffect.shadow
    property color color: Neumorphism.color

    implicitWidth: 50
    implicitHeight: 50

    ShaderEffect {
        id: shadowEffect

        implicitWidth: parent.width
        implicitHeight: parent.height

        property Shadow shadow: Shadow {
            offset: 10; angle: 45; distance: 0.4; radius: 10; spread: 10
            color1: Qt.lighter(control.color, 1.40)
            color2: Qt.darker (control.color, 1.25)
        }

        readonly property real whmax: Math.max(width, height)
        readonly property vector2d ratio: Qt.vector2d(width / whmax, height / whmax)
        readonly property color color1: shadow.color1
        readonly property color color2: shadow.color2
        readonly property real spread: shadow.spread / whmax
        readonly property real offset: shadow.offset / whmax
        readonly property real angle: shadow.angle * 0.0174533
        readonly property real shdiff: shadow.distance
        readonly property real smoothstp: 2 / whmax
        readonly property real radius: {
            const min = Math.min(width, height)/2;
            return Math.min(Math.max(shadow.radius, shadow.spread), min) / whmax;
        }

        fragmentShader: "source/RoundedOutEffect.frag.qsb"
    }
}
