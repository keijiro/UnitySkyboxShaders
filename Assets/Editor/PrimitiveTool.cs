using UnityEngine;
using UnityEditor;

public static class PrimitiveTool
{
    [MenuItem("Extra/Create Square Mesh Asset")]
    static void CreateSquareMeshAsset ()
    {
        var mesh = new Mesh ();

        var vertices = new Vector3 [8];

        vertices [0] = new Vector3 (-1, +1, 0);
        vertices [1] = new Vector3 (+1, +1, 0);
        vertices [2] = new Vector3 (-1, -1, 0);
        vertices [3] = new Vector3 (+1, -1, 0);
        vertices [4] = new Vector3 (+1, +1, 0);
        vertices [5] = new Vector3 (-1, +1, 0);
        vertices [6] = new Vector3 (+1, -1, 0);
        vertices [7] = new Vector3 (-1, -1, 0);

        var indices = new int[12];

        indices [0] = 0;
        indices [1] = 1;
        indices [2] = 2;

        indices [3] = 1;
        indices [4] = 3;
        indices [5] = 2;

        indices [6] = 4;
        indices [7] = 5;
        indices [8] = 6;

        indices [9] = 5;
        indices [10] = 7;
        indices [11] = 6;

        mesh.vertices = vertices;
        mesh.SetIndices (indices, MeshTopology.Triangles, 0);

        mesh.Optimize ();
        mesh.RecalculateNormals ();
        
        AssetDatabase.CreateAsset (mesh, "Assets/Misc/Square.asset");
        AssetDatabase.ImportAsset ("Assets/Misc/Square.asset");
    }
}