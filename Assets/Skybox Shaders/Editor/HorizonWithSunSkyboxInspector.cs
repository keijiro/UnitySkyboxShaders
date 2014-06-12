using UnityEngine;
using UnityEditor;

public class HorizonWithSunSkyboxInspector : MaterialEditor
{
    public override void OnInspectorGUI ()
    {
        serializedObject.Update ();

        if (isVisible)
        {
            EditorGUI.BeginChangeCheck ();

            GUILayout.Label ("Background Parameters");

            EditorGUILayout.Space ();

            ColorProperty (GetMaterialProperty (targets, "_SkyColor1"), "Top Color");
            FloatProperty (GetMaterialProperty (targets, "_SkyExponent1"), "Exponential Factor");

            EditorGUILayout.Space ();

            ColorProperty (GetMaterialProperty (targets, "_SkyColor2"), "Horizon Color");

            EditorGUILayout.Space ();

            ColorProperty (GetMaterialProperty (targets, "_SkyColor3"), "Bottom Color");
            FloatProperty (GetMaterialProperty (targets, "_SkyExponent2"), "Exponential Factor");

            EditorGUILayout.Space ();

            FloatProperty (GetMaterialProperty (targets, "_SkyIntensity"), "Intensity");

            EditorGUILayout.Space ();

            GUILayout.Label ("Sun Parameters");

            EditorGUILayout.Space ();

            ColorProperty (GetMaterialProperty (targets, "_SunColor"), "Color");
            FloatProperty (GetMaterialProperty (targets, "_SunIntensity"), "Intensity");

            EditorGUILayout.Space ();

            FloatProperty (GetMaterialProperty (targets, "_SunAlpha"), "Alpha");
            FloatProperty (GetMaterialProperty (targets, "_SunBeta"), "Beta");

            EditorGUILayout.Space ();

            var az = GetMaterialProperty (targets, "_SunAzimuth");
            var al = GetMaterialProperty (targets, "_SunAltitude");

            if (az.hasMixedValue || al.hasMixedValue )
            {
                EditorGUILayout.HelpBox ("Editing angles is disabled because they have mixed values.", MessageType.Warning);
            }
            else
            {
                FloatProperty (az, "Azimuth");
                FloatProperty (al, "Altitude");
            }

            if (EditorGUI.EndChangeCheck ())
            {
                var raz = az.floatValue * Mathf.Deg2Rad;
                var ral = al.floatValue * Mathf.Deg2Rad;
                
                var upVector = new Vector4 (
                    Mathf.Cos (ral) * Mathf.Sin (raz),
                    Mathf.Sin (ral),
                    Mathf.Cos (ral) * Mathf.Cos (raz),
                    0.0f
                );
                GetMaterialProperty (targets, "_SunVector").vectorValue = upVector;

                PropertiesChanged ();
            }
        }
    }
}
