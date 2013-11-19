using UnityEngine;
using UnityEditor;
using System.Collections;

public class GradientSkyboxInspector : MaterialEditor
{
    public override void OnInspectorGUI ()
    {
        if (!isVisible) {
            return;
        }

        var m = target as Material;
        var dp = m.GetFloat ("_UpVectorPitch");
        var dy = m.GetFloat ("_UpVectorYaw");

        EditorGUI.BeginChangeCheck ();

        ColorProperty (GetMaterialProperty (targets, "_Color2"), "Top Color");
        ColorProperty (GetMaterialProperty (targets, "_Color1"), "Bottom Color");
        dp = EditorGUILayout.FloatField ("Pitch", dp);
        dy = EditorGUILayout.FloatField ("Yaw", dy);

        if (EditorGUI.EndChangeCheck ()) {
            var rp = dp * Mathf.Deg2Rad;
            var ry = dy * Mathf.Deg2Rad;

            var upVector = new Vector4 (
                Mathf.Sin (rp) * Mathf.Sin (ry),
                Mathf.Cos (rp),
                Mathf.Sin (rp) * Mathf.Cos (ry),
                0.0f
            );

            m.SetVector ("_UpVector", upVector);
            m.SetFloat ("_UpVectorPitch", dp);
            m.SetFloat ("_UpVectorYaw", dy);

            PropertiesChanged();
        }
    }
}
